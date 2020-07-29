#!/bin/bash

if [[ ! -d ~/.config ]]; then
    mkdir ~/.config
fi

cat << EOF > ~/.config/monitors.xml
<monitors version="1">
  <configuration>
      <clone>no</clone>
      <output name="Virtual1">
          <vendor>???</vendor>
          <product>0x0000</product>
          <serial>0x00000000</serial>
          <width>1400</width>
          <height>1050</height>
          <rate>60</rate>
          <x>0</x>
          <y>0</y>
          <rotation>normal</rotation>
          <reflect_x>no</reflect_x>
          <reflect_y>no</reflect_y>
          <primary>yes</primary>
      </output>
      <output name="Virtual2">
      </output>
      <output name="Virtual3">
      </output>
      <output name="Virtual4">
      </output>
      <output name="Virtual5">
      </output>
      <output name="Virtual6">
      </output>
      <output name="Virtual7">
      </output>
      <output name="Virtual8">
      </output>
  </configuration>
</monitors>
EOF

echo "xrandr --output Virtual1 --mode 1440x900 --rate 60" > "$HOME"/.xprofile
# dconf write /org/compiz/profiles/unity/plugins/core/outputs "['1440x900+0+0']"
