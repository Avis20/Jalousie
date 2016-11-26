# Jalousie
URL - https://avis20.github.io/Jalousie/
Server start - browser-sync start --server --files "*.*, css/*.*, js/*.*"

# Apache settings
1. copy config:
 * sudo cp /home/avis/develop/sites/jalousie/jalousie.conf /etc/apache2/sites-available/
2. add links:
 * sudo link /etc/apache2/mods-available/cgid.load /etc/apache2/mods-enabled/cgid.load
 * sudo link /etc/apache2/mods-available/cgid.conf /etc/apache2/mods-enabled/cgid.conf
3. dissable and enabled configs:
 * sudo a2dissite 000-default.conf
 * sudo a2dissite default-ssl.conf
 * sudo a2ensite jalousie.conf
4. reload and restart apache
 * sudo service apache2 reload
5. in browser:
 * localhost:80
