echo "Starting the entire project..."
sudo docker-compose -f ./docker-compose-setup/docker-compose.yml up -d --build
echo "All Done, Container is up and running."
echo "Visite http://$(hostname -I | cut -d' ' -f1):9000 (for container management)"
echo "Visite http://$(hostname -I | cut -d' ' -f1):1880 (for backend)."
echo "Visite http://$(hostname -I | cut -d' ' -f1):3000 (for frontend)"
