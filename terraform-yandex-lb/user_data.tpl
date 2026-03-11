#!/bin/bash

# Обновление системы
apt-get update
apt-get upgrade -y

# Установка Apache
apt-get install -y apache2

# Создание веб-страницы со ссылкой на картинку
cat > /var/www/html/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Instance Group - Лебедев В.В.</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f0f0f0;
            color: #333;
        }
        h1 { color: #2c3e50; }
        .container {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            text-align: center;
        }
        img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            margin: 20px 0;
        }
        .info {
            background-color: #e8f4f8;
            padding: 10px;
            border-radius: 4px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Instance Group - Лебедев В.В.</h1>
        <p>Студент: Лебедев В.В.</p>
        <p>Группа: FOPS-33</p>
        <p>Хост: $(hostname)</p>
        <p>IP адрес: $(hostname -I | awk '{print $1}')</p>
        
        <h2>Картинка из Object Storage:</h2>
        <img src="${image_url}" alt="Image from Object Storage">
        
        <div class="info">
            <p>Эта картинка загружена из бакета Object Storage</p>
            <p><a href="${image_url}" target="_blank">Прямая ссылка на картинку</a></p>
        </div>
    </div>
</body>
</html>
EOF

# Запуск Apache
systemctl enable apache2
systemctl start apache2

# Проверка статуса
systemctl status apache2 --no-pager
