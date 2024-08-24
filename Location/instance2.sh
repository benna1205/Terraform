#!/bin/bash
sudo apt update
sudo apt install nginx -y
echo "<!DOCTYPE html>
<html lang=\"en\">
<head>
    <meta charset=\"UTF-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
    <title>Server1</title>
    <link rel=\"stylesheet\" href=\"styles.css\">
</head>
<body>
    <header>
        <h1>Welcome to My Server2</h1>
        <nav>
            <ul>
                <li><a href=\"https://docs.ansible.com/ansible/latest/terraform\">Ansible</a></li>
            </ul>
        </nav>
    </header>

    <section id=\"about\">
        <h2>About Us</h2>
        <p>We have successfully installed our server2 by calling variables.</p>
    </section>
</body>
</html>" > /var/www/html/index.html
sudo systemctl enable nginx
sudo systemctl start nginx
