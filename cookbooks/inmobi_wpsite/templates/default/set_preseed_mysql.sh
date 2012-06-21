
echo "mysql-server-5.1 mysql-server/root_password password <%= node[:inmobi_wpsite][:mysql_root_password] %>" > /tmp/preseed.tmp
echo "mysql-server-5.1 mysql-server/root_password_again password <%= node[:inmobi_wpsite][:mysql_root_password] %>" >> /tmp/preseed.tmp
echo "mysql-server-5.1 mysql-server/start_on_boot boolean true" >> /tmp/preseed.tmp
cat /tmp/preseed.tmp | debconf-set-selections
