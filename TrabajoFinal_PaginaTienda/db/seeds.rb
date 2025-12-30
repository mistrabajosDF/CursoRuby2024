#Roles
admin_role = Role.create!(name: 'Administrador')
manager_role = Role.create!(name: 'Gerente')
employee_role = Role.create!(name: 'Empleado')

#Categorías
category1 = Category.create!(name: 'Calzado')
category2 = Category.create!(name: 'Remeras')
category3 = Category.create!(name: 'Shorts')
category4 = Category.create!(name: 'Muñequeras')
category5 = Category.create!(name: 'Buzos y camperas')

#Usuarios
user1 = User.create!(name: 'User empleado', username: 'empleadouser', mail: 'empleado@gmail.com', phone: 1123456789, password: 'password123', state: true, entrydate: Date.today, role_id: employee_role.id)
user2 = User.create!(name: 'User gerente', username: 'gerenteuser', mail: 'gerente@gmail.com', phone: 1134567890, password: 'password123', state: true, entrydate: Date.today, role_id: manager_role.id)
user3 = User.create!(name: 'User admin', username: 'adminuser', mail: 'admin@gmail.com', phone: 1145678901, password: 'password123', state: true, entrydate: Date.today, role_id: admin_role.id)

#Clientes
Customer.create!(
  name: 'User cliente', username: 'clienteuser', email: 'cliente@gmail.com', address: 'Calle Falsa 123', phone: '1123456789', password: 'password123', password_confirmation: 'password123')

#Productos
product1 = Product.create!(name: 'Zapatillas tipo bota', description: 'Zapatillas multicolores.', stock: 100, price: 50000, talle: 37, color: 'Varios', state: true, category_id: category1.id)
product1.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'zapatillas.jpg')), filename: 'zapatillas.jpg')

product2 = Product.create!(name: 'Remera manga corta', description: 'Con estampado de gatos.', stock: 200, price: 15000, talle: nil, color: 'Blanco', state: true, category_id: category2.id)
product2.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'remera.jpg')), filename: 'remera.jpg')

product3 = Product.create!(name: 'Shorts sueltos', description: 'Shorts de jean pintado.', stock: 150, price: 8000, talle: 34, color: 'Amarillo', state: true, category_id: category3.id)
product3.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'short.jpg')), filename: 'short.jpg')

product4 = Product.create!(name: 'Muñequera elastizada', description: 'Muñequera de tela elástica.', stock: 50, price: 800, talle: nil, color: 'Rojo', state: true, category_id: category4.id)

product5 = Product.create!(name: 'Buzo de algodón', description: 'Buzo elastizado con tela lisa y estampada.', stock: 200, price: 30000, talle: 42, color: 'Negro y estampado', state: true, category_id: category5.id)
product5.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'buzo.jpg')), filename: 'buzo.jpg')

product6 = Product.create!(name: 'Campera jean', description: 'Campera pintada con tachas en la espalda.', stock: 1200, price: 25000, talle: 40, state: true, category_id: category5.id)


# Crear Ventas
sale1 = Sale.create!(customer_name: 'Juan Pérez', state: true, user_id: user1.id, total: 38000, products: [{ product_id: 1, price: product1.price, quantity: 1 },
{ product_id: product2.id, price: product2.price, quantity: 2 }])

sale2 = Sale.create!(customer_name: 'Ana López', state: true, user_id: user2.id, total: 15900, products: [{ product_id: 4, price: 500.0, quantity: 1 },
{ product_id: 2, price: 3850.0, quantity: 4 }])

sale3 = Sale.create!(customer_name: 'Luis Martínez', state: true, user_id: user3.id, total: 4050, products: [{ product_id: 2, price: 2250.0, quantity: 1 },
{ product_id: 1, price: 300.0, quantity: 6 }])

sale4 = Sale.create!(customer_name: 'Marta García', state: false, user_id: user1.id, total: 11180, products: [{ product_id: 1, price: 50.0, quantity: 1 },
{ product_id: 2, price: 11130.0, quantity: 1 }])

sale5 = Sale.create!(customer_name: 'Carlos Ruiz', state: true, user_id: user2.id, total: 20000, products: [{ product_id: 1, price: 5000.0, quantity: 3 },
{ product_id: 2, price: 2500.0, quantity: 2 }])


puts "Datos de prueba cargados 8)."
