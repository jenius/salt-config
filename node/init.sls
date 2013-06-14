node_deps:
  pkg.installed:
    - names:
      - libssl-dev
      - git
      - pkg-config
      - build-essential
      - curl
      - gcc
      - g++
      - checkinstall

get-node:
  file.managed:
    - name: /usr/src/node-v{{ pillar['node']['version'] }}.tar.gz
    - source: http://nodejs.org/dist/v{{ pillar['node']['version'] }}/node-v{{ pillar['node']['version'] }}.tar.gz
    - source_hash: {{ pillar['node']['checksum'] }}
    - require:
      - pkg: node_deps

unzip-node:
  cmd.run:
    - cwd: /usr/src
    - names:
      - tar -zxvf node-v{{ pillar['node']['version'] }}.tar.gz
    - require:
      - file: /usr/src/node-v{{ pillar['node']['version'] }}.tar.gz

#
# make and install node
#

make_node:
  cmd.run:
    - cwd: /usr/src/node-v{{ pillar['node']['version'] }}
    - names:
      - ./configure
      - make
      - make install
    - require:
      - cmd: unzip-node
