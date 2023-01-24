echo "Starting the entire project..."
sudo docker-compose -f ./docker-compose-setup/docker-compose.yml up -d --build
echo "All Done, Container is up and running."
echo "Visit http://$(hostname -I | cut -d' ' -f1):9000 (for container management)"
echo "Visit http://$(hostname -I | cut -d' ' -f1):1880 (for backend)."
echo "Visit http://$(hostname -I | cut -d' ' -f1):3000 (for frontend)"
echo "Visit http://$(hostname -I | cut -d' ' -f1):8080 (if you have enabled the SMS example-notification-service)"
