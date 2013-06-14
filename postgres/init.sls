postgresql:
  pkg:
    - installed
  service.running:
    - enable: True

root_user:
  postgres_user.present:
    - name: root
    - password: root
    - runas: postgres
    - require:
      - service: postgresql

root_db:
  postgres_database.present:
    - name: root
    - encoding: UTF8
    - lc_ctype: en_US.UTF8
    - lc_collate: en_US.UTF8
    - template: template0
    - owner: root
    - runas: postgres
    - require:
      - postgres_user: root
