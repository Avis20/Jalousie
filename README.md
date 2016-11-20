# Jalousie
URL - https://avis20.github.io/Jalousie/
Server start - browser-sync start --server --files "*.*, css/*.*, js/*.*"

# Apache settings
1 add links:
  * sudo link /etc/apache2/mods-available/cgi.load /etc/apache2/mods-enabled/cgi.load
  * sudo link /etc/apache2/mods-available/cgi.conf /etc/apache2/mods-enabled/cgi.conf
2 dissable 000-default.conf and enabled jalouise.conf
  * a2dissite 000-default.conf
  * a2ensite jalousie.conf