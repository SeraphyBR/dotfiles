#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Usage:
# 1. Save as `vt-color-scheme.py` in $PATH (/usr/bin for example)
# 2. Make executable `chmod +x vt-color-scheme.py`
# 3. Add `$(vt-color-scheme.py)` to `GRUB_CMDLINE_LINUX` in `/etc/default/grub`
#   example `GRUB_CMDLINE_LINUX="$(vt-color-scheme.py)"`
# 4. Create new grub config with `sudo grub-mkconfig -o /boot/grub/grub.cfg`
# 5. Reboot to apply changes

KERNEL_PARAMS = ['vt.default_red', 'vt.default_grn', 'vt.default_blu', ]

COLOR_SCHEME = [
    '0x4c4c4c',
    '0xff6c6c',
    '0xa3df4c',
    '0xdbee77',
    '0x5cb64f',
    '0xb981f4',
    '0x27c3ff',
    '0xffffff',
    '0x6383a7',
    '0xf9546d',
    '0x4fdaee',
    '0xdbee77',
    '0x69c35c',
    '0xb981f4',
    '0x7097ff',
    '0xffffff'
]

def color_scheme_to_rgb_channel_data(color_scheme):
    """
    [ '#r1g1b1', '#r2g2b2', ... ] => [ [r1, r2, ...], [g1, g2, ...], [b1, b2, ...], ]
    """

    def split_to_rgb(color):
        # rgb str -> [red, green, blue]
        hex_value = int(color, 16)
        return [hex_value >> 16 & 255, hex_value >> 8 & 255, hex_value & 255]

    return zip(*[split_to_rgb(color.strip('#')) for color in color_scheme])


def prepare_param(param, channel_data):
    return '{param}={values}'.format(param=param, values=','.join(hex(byte) for byte in channel_data))


def main(colors):
    print(' '.join(prepare_param(param, channel) for param, channel in \
                   zip(KERNEL_PARAMS, color_scheme_to_rgb_channel_data(colors))))


if __name__ == '__main__':
    main(COLOR_SCHEME)
