read -p "Продолжить выполнение ${BASH_SOURCE[0]}? (y/n): " answer

if ! [[ "$answer" =~ ^[YyДд] ]]; then
    echo "Вы выбрали НЕТ. Выход..."
    return
fi
echo "Вы выбрали ДА. Выполняем действие..."

sudo sed -i  's|<policy domain="coder" rights="none" pattern="PDF" />|<!-- <policy domain="coder" rights="none" pattern="PDF"/> -->|' /etc/ImageMagick-6/policy.xml
