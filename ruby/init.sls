# 
# ruby deps
# 
 
rbenv_deps:
  pkg.installed:
    - names:
      - git
      - build-essential
      - openssl
      - curl
      - zlib1g
      - zlib1g-dev
      - libssl-dev
      - libyaml-dev
      - libsqlite3-0
      - libsqlite3-dev
      - sqlite3
      - libxml2-dev
      - libxslt1-dev
      - autoconf
      - libc6-dev
      - libncurses5-dev
      - automake
      - libtool
      - bison
      - subversion
 
# 
# rbenv and ruby-build installation
# 

/root/.rbenv:
  file.directory:
    - makedirs: True

https://github.com/sstephenson/rbenv.git:
  git.latest:
    - rev: master
    - target: /root/.rbenv
    - force: True
    - require:
      - pkg: rbenv_deps
      - file: /root/.rbenv

https://github.com/sstephenson/ruby-build.git:
  git.latest:
    - rev: master
    - target: /root/.rbenv/plugins/ruby-build
    - force: True
    - require:
      - git: https://github.com/sstephenson/rbenv.git
      - file: /root/.rbenv
 
/root/.profile:
  file.append:
    - text:
      - export PATH="$HOME/.rbenv/bin:$PATH"
      - eval "$(rbenv init -)"
    - require:
      - git: https://github.com/sstephenson/rbenv.git

#
# ruby installation
#

# ruby-{{ pillar['ruby']['version'] }}:
#   rbenv.installed:
#     - default: True
#     - require:
#       - git: https://github.com/sstephenson/ruby-build.git

/root/.rbenv/bin/rbenv install {{ pillar['ruby']['version'] }}:
  cmd.run:
  - require:
    - git: https://github.com/sstephenson/ruby-build.git

/root/.rbenv/bin/rbenv rehash:
  cmd.run:
    - require:
      - cmd: /root/.rbenv/bin/rbenv install {{ pillar['ruby']['version'] }}

/root/.rbenv/bin/rbenv global {{ pillar['ruby']['version'] }}:
  cmd.run:
    - require:
      - cmd: /root/.rbenv/bin/rbenv rehash

