#!/usr/bin/env python

# TODO: File watcher.

from datetime import datetime, timedelta
import json
import locale
from subprocess import Popen, PIPE, STDOUT
import sys
import time

import alsaaudio
import netifaces

GREEN = "#00FF00"
OFFLINEIMAP_CONFIG_DIR = "~/.config/offlineimap/"
PURPLE = "#FF00FF"
RED = "#FF0000"
SLEEP_TIME = 1
SUMMARY_LEN = 15
TURQUOISE = "#00FFFF"
YELLOW = "#FFFF00"

default_locale = locale.getdefaultlocale()
locale.setlocale(locale.LC_ALL, default_locale)

class Unbuffered(object):
   def __init__(self, stream):
       self.stream = stream
   def write(self, data):
       self.stream.write(data)
       self.stream.flush()
   def __getattr__(self, attr):
       return getattr(self.stream, attr)

sys.stdout = Unbuffered(sys.stdout)

print("{\"version\": 1}")
print("[")
print("[]")

def get_events():
    cmd = r"remind -s+2 ~/.config/remind/reminders.rem"
    process = Popen(cmd, shell=True, stdin=PIPE, stdout=PIPE, stderr=STDOUT, close_fds=True)
    lines = process.stdout.read().decode("utf-8").split("\n")
    lines.pop()
    events = []
    for line in lines:
        parts = line.split(" ")
        if "am" in parts[5]:
            start_time = parts[5].split("-")[0].replace("am", "").replace("pm", "")
        else:
            (hours, minutes) = parts[5].split("-")[0].split(":")
            hours = int(hours) + 12
            if hours == 24:
                hours = 0
            start_time = str(hours) + ":" + minutes
        date = datetime.strptime(parts[0] + " " + start_time, "%Y/%m/%d %H:%M")
        current_date = datetime.now()
        date_in_one_week = current_date + timedelta(days=7)
        hour = parts[5]
        index = line.index(hour) + len(hour) + 1
        summary = ""
        summary_words = line[index:].split(" ")
        i = 0
        while len(summary) < SUMMARY_LEN and i < len(summary_words):
            summary += summary_words[i] + " "
            i += 1
        summary = summary.strip(" .:")
        if date.timestamp() >= current_date.timestamp() and date.timestamp() < date_in_one_week.timestamp():
            events.append({
                "date": date,
                "summary": summary,
            })
    return events

def get_mailboxes():
    cmd = r"find %s -maxdepth 1 -mindepth 1 -type d -printf '%%f\n'" % OFFLINEIMAP_CONFIG_DIR
    process = Popen(cmd, shell=True, stdin=PIPE, stdout=PIPE, stderr=STDOUT, close_fds=True)
    data = process.stdout.read().decode("utf-8")
    mailboxes = data.split("\n")
    mailboxes.pop()
    return mailboxes

def get_network_interface_address():
    interfaces = netifaces.interfaces()
    for interface in interfaces:
        addresses = netifaces.ifaddresses(interface)
        try:
            address = addresses[netifaces.AF_INET][0]["addr"]
            if address != "127.0.0.1":
                return (interface, address)
        except KeyError:
            pass

def unread_mail(mailbox):
    cmd = "find %s%s/*/new -type f | wc -l" % (OFFLINEIMAP_CONFIG_DIR, mailbox)
    process = Popen(cmd, shell=True, stdin=PIPE, stdout=PIPE, stderr=STDOUT, close_fds=True)
    return int(process.stdout.read())

while True:
    data = []

    # Events.
    events = get_events()
    for event in events:
        date = event["date"]
        data.append({
            "color": PURPLE,
            "name": "event_%s" % date.strftime("%d-%m"),
            "full_text": date.strftime("%d %B").strip("0") + ": " + event["summary"],
        })

    # Mail boxes.
    def mail(mailbox):
        unread_mail_count = unread_mail(mailbox)
        if unread_mail_count > 0:
            data.append({
                "color": TURQUOISE,
                "name": "%s_email" % mailbox,
                "full_text": "✉ " + mailbox + " (" + str(unread_mail_count) + ")",
            })

    for mailbox in get_mailboxes():
        mail(mailbox)

    # Network.
    result = get_network_interface_address()
    if result is not None:
        (interface, address) = result
        data.append({
            "color": GREEN,
            "name": "network",
            "full_text": interface[0].upper() + ": " + address
        })
    else:
        data.append({
            "color": RED,
            "name": "network",
            "full_text": "No network",
        })

    # Volume.
    mixer = alsaaudio.Mixer()
    if mixer.getmute()[0]:
        data.append({
            "color": YELLOW,
            "name": "volume",
            "full_text": "♪: 0%",
        })
    else:
        data.append({
            "name": "volume",
            "full_text": "☊ " + str(mixer.getvolume()[0]) + "%",
        })

    # Date and time.
    now = datetime.now()
    data.append({
        "name": "datetime",
        "full_text": now.strftime("%A %-d %B %Y ⌚ %-H:%M"),
    })

    # GMT time.
    #now = datetime.utcnow()
    #data.append({
        #"name": "datetime",
        #"full_text": now.strftime("⌚ %-H:%M"),
    #})

    # Show and sleep.
    print(",", json.dumps(data))
    time.sleep(SLEEP_TIME)
