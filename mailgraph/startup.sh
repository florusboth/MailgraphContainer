echo "Starting apache2.."
service apache2 start
echo "  done"

echo "Starting mailgraph.."
sh /var/mailgraph/mailgraph-init start
echo "  done"

tail -f /dev/null
