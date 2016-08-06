#!/usr/bin/env python

from datetime import datetime
import json
import locale
from subprocess import Popen, PIPE, STDOUT
import sys
import time

import alsaaudio
import netifaces

GREEN = "#00FF00"
OFFLINEIMAP_CONFIG_DIR = "~/.config/offlineimap/"
RED = "#FF0000"
SLEEP_TIME = 1
TURQUOISE = "#00FFFF"

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

    # Show and sleep.
    print(",", json.dumps(data))
    time.sleep(SLEEP_TIME)
