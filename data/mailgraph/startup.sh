echo "Starting apache2.."
service apache2 start
echo "  done"

echo "Starting mailgraph.."
sh /var/www/mailgraph/mailgraph-init start
echo "  done"

/bin/bash
