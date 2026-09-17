import 'package:flutter/material.dart';

void main() {
  runApp(const GutipalStyleApp());
}

class GutipalStyleApp extends StatelessWidget {
  const GutipalStyleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GUTIPAL STYLE',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8E5AA7),
        ),
        scaffoldBackgroundColor: const Color(0xFFFDF9FD),
      ),
      home: const HomePage(),
    );
  }
}

class Product {
  final String name;
  final String description;
  final double price;
  final String image;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;

  final List<Product> products = [
    Product(
      name: 'Vestido Elegance',
      description: 'Vestido moderno y elegante para toda ocasión.',
      price: 45.00,
      image:
          'https://images.unsplash.com/photo-1496747611176-843222e1e57c?auto=format&fit=crop&w=700&q=80',
    ),
    Product(
      name: 'Casaca Urban',
      description: 'Casaca moderna para un estilo casual.',
      price: 60.00,
      image:
          'https://images.unsplash.com/photo-1551488831-00ddcb6c6bd3?auto=format&fit=crop&w=700&q=80',
    ),
    Product(
      name: 'Polo Essential',
      description: 'Polo básico, cómodo y versátil.',
      price: 25.00,
      image:
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=700&q=80',
    ),
    Product(
      name: 'Jean Classic',
      description: 'Jean clásico con diseño moderno.',
      price: 55.00,
      image:
          'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?auto=format&fit=crop&w=700&q=80',
    ),
  ];

  final List<Product> cart = [];

  void addToCart(Product product) {
    setState(() {
      cart.add(product);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} fue agregado al carrito'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void removeFromCart(Product product) {
    setState(() {
      cart.remove(product);
    });
  }

  void goToPage(int page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildCurrentPage(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      surfaceTintColor: Colors.white,
      title: InkWell(
        onTap: () => goToPage(0),
        child: const Text(
          'GUTIPAL STYLE',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: Color(0xFF6D3F7A),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => goToPage(0),
          child: const Text('Inicio'),
        ),
        TextButton(
          onPressed: () => goToPage(1),
          child: const Text('Productos'),
        ),
        TextButton(
          onPressed: () => goToPage(2),
          child: const Text('Nosotros'),
        ),
        TextButton(
          onPressed: () => goToPage(3),
          child: const Text('Contacto'),
        ),
        const SizedBox(width: 8),
        Stack(
          children: [
            IconButton(
              tooltip: 'Carrito',
              onPressed: () => goToPage(4),
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Color(0xFF6D3F7A),
              ),
            ),
            if (cart.isNotEmpty)
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${cart.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 15),
      ],
    );
  }

  Widget _buildCurrentPage() {
    switch (currentPage) {
      case 1:
        return _productsPage();
      case 2:
        return _aboutPage();
      case 3:
        return _contactPage();
      case 4:
        return _cartPage();
      default:
        return _homePage();
    }
  }

  Widget _homePage() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 70,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFF4E7F7),
                  Color(0xFFFFFBFF),
                ],
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final bool mobile = constraints.maxWidth < 750;

                if (mobile) {
                  return Column(
                    children: [
                      _heroText(center: true),
                      const SizedBox(height: 40),
                      _heroImage(
                        width: 280,
                        height: 320,
                      ),
                    ],
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: _heroText(center: false),
                    ),
                    const SizedBox(width: 50),
                    _heroImage(
                      width: 400,
                      height: 420,
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 60),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '¿POR QUÉ ELEGIR GUTIPAL STYLE?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3A293E),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Wrap(
              spacing: 25,
              runSpacing: 25,
              alignment: WrapAlignment.center,
              children: [
                _benefitCard(
                  Icons.local_shipping_outlined,
                  'Envíos',
                  'Recibe tus productos de forma rápida y segura.',
                ),
                _benefitCard(
                  Icons.verified_outlined,
                  'Calidad',
                  'Prendas seleccionadas pensando en tu comodidad.',
                ),
                _benefitCard(
                  Icons.lock_outline,
                  'Pagos seguros',
                  'Compra de manera sencilla y segura.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 70),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: const Color(0xFFEBD9F0),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                const Text(
                  'Descubre tu próximo estilo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6D3F7A),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Conoce nuestra colección y encuentra '
                  'la prenda perfecta para ti.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () => goToPage(1),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8E5AA7),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35,
                      vertical: 18,
                    ),
                  ),
                  child: const Text(
                    'VER COLECCIÓN',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 70),
          _footer(),
        ],
      ),
    );
  }

  Widget _heroText({required bool center}) {
    return Column(
      crossAxisAlignment:
          center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'GUTIPAL STYLE',
          textAlign: center ? TextAlign.center : TextAlign.left,
          style: const TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6D3F7A),
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          'Moda que realza tu esencia',
          textAlign: center ? TextAlign.center : TextAlign.left,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: Color(0xFF3A293E),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 600,
          child: Text(
            'Descubre prendas modernas, cómodas y '
            'elegantes pensadas para resaltar tu estilo.',
            textAlign: center ? TextAlign.center : TextAlign.left,
            style: const TextStyle(
              fontSize: 17,
              height: 1.6,
              color: Colors.black54,
            ),
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton.icon(
          onPressed: () => goToPage(1),
          icon: const Icon(Icons.shopping_bag_outlined),
          label: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            child: Text(
              'VER PRODUCTOS',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8E5AA7),
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _heroImage({
    required double width,
    required double height,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Image.network(
        'https://images.unsplash.com/photo-1483985988355-763728e1935b?auto=format&fit=crop&w=800&q=80',
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            color: const Color(0xFFEBD9F0),
            child: const Icon(
              Icons.checkroom,
              size: 120,
              color: Color(0xFF8E5AA7),
            ),
          );
        },
      ),
    );
  }

  Widget _benefitCard(
    IconData icon,
    String title,
    String text,
  ) {
    return SizedBox(
      width: 280,
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Icon(
                icon,
                size: 45,
                color: const Color(0xFF8E5AA7),
              ),
              const SizedBox(height: 15),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _productsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          const Text(
            'NUESTROS PRODUCTOS',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6D3F7A),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Encuentra prendas para cada momento.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate:
                const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 310,
              mainAxisExtent: 470,
              crossAxisSpacing: 25,
              mainAxisSpacing: 25,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return _productCard(product);
            },
          ),
          const SizedBox(height: 60),
          _footer(),
        ],
      ),
    );
  }

  Widget _productCard(Product product) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 245,
            child: Image.network(
              product.image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFFF0E4F3),
                  child: const Icon(
                    Icons.image_not_supported_outlined,
                    size: 80,
                    color: Color(0xFF8E5AA7),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  Text(
                    product.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3A293E),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black54,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'S/ ${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6D3F7A),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => addToCart(product),
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                      ),
                      label: const Text(
                        'Agregar al carrito',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8E5AA7),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // NOSOTROS
  // =========================

  Widget _aboutPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          const Icon(
            Icons.storefront_outlined,
            size: 85,
            color: Color(0xFF8E5AA7),
          ),
          const SizedBox(height: 20),
          const Text(
            'SOBRE GUTIPAL STYLE',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6D3F7A),
            ),
          ),
          const SizedBox(height: 30),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 850,
            ),
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(35),
                child: Column(
                  children: [
                    const Text(
                      'Nuestra tienda',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // TEXTO NUEVO DE GUTIPAL STYLE
                    const Text(
                      'Gutipal Style es una marca de ropa creada para '
                      'quienes buscan destacar con autenticidad, frescura '
                      'y un flow único en cada outfit. Nos dedicamos a '
                      'transformar las tendencias del momento en un estilo '
                      'de vida, ofreciendo prendas de alta calidad que '
                      'combinan comodidad, actitud y diseño.\n\n'
                      'No vendemos solo ropa; entregamos la confianza y '
                      'la personalidad que necesitas para brillar y '
                      'conquistar el mundo día a día.\n\n'
                      'Viste con identidad, viste Gutipal Style.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        height: 1.7,
                        color: Colors.black54,
                      ),
                    ),

                    const SizedBox(height: 30),

                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      alignment: WrapAlignment.center,
                      children: [
                        _aboutFeature(
                          Icons.favorite_outline,
                          'Estilo',
                          'Moda para expresar tu personalidad.',
                        ),
                        _aboutFeature(
                          Icons.workspace_premium_outlined,
                          'Calidad',
                          'Productos seleccionados para ti.',
                        ),
                        _aboutFeature(
                          Icons.people_outline,
                          'Atención',
                          'Pensamos siempre en nuestros clientes.',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 60),
          _footer(),
        ],
      ),
    );
  }

  Widget _aboutFeature(
    IconData icon,
    String title,
    String text,
  ) {
    return SizedBox(
      width: 220,
      child: Column(
        children: [
          Icon(
            icon,
            size: 40,
            color: const Color(0xFF8E5AA7),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // CONTACTO
  // =========================

  Widget _contactPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          const Text(
            'CONTÁCTANOS',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6D3F7A),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Estamos aquí para ayudarte',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 40),

          Wrap(
            spacing: 25,
            runSpacing: 25,
            alignment: WrapAlignment.center,
            children: [
              _contactCard(
                Icons.phone_outlined,
                'Teléfono',
                '935420787',
              ),

              _contactCard(
                Icons.email_outlined,
                'Correo electrónico',
                'contacto@gutipalstyle.com',
              ),

              _contactCard(
                Icons.location_on_outlined,
                'Ubicación',
                'Huanta, Perú',
              ),

              _contactCard(
                Icons.access_time,
                'Horario de atención',
                'Lun - Sáb\n9:00 AM - 7:00 PM',
              ),
            ],
          ),

          const SizedBox(height: 50),

          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 700,
            ),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Envíanos un mensaje',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6D3F7A),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Completa el formulario y nos '
                      'pondremos en contacto contigo.',
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 25),

                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Nombre completo',
                        prefixIcon: const Icon(
                          Icons.person_outline,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Correo electrónico',
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Número de teléfono',
                        prefixIcon: const Icon(
                          Icons.phone_outlined,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Escribe tu mensaje',
                        alignLabelWithHint: true,
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(bottom: 75),
                          child: Icon(
                            Icons.message_outlined,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                '¡Mensaje enviado correctamente! '
                                'Nos comunicaremos contigo pronto.',
                              ),
                              behavior:
                                  SnackBarBehavior.floating,
                            ),
                          );
                        },
                        icon: const Icon(Icons.send),
                        label: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                          child: Text(
                            'ENVIAR MENSAJE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF8E5AA7),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 60),
          _footer(),
        ],
      ),
    );
  }

  Widget _contactCard(
    IconData icon,
    String title,
    String text,
  ) {
    return SizedBox(
      width: 280,
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Icon(
                icon,
                size: 42,
                color: const Color(0xFF8E5AA7),
              ),
              const SizedBox(height: 15),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cartPage() {
    final double total = cart.fold(
      0,
      (sum, product) => sum + product.price,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          const Text(
            'MI CARRITO',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6D3F7A),
            ),
          ),
          const SizedBox(height: 35),

          if (cart.isEmpty)
            const Column(
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 100,
                  color: Colors.black26,
                ),
                SizedBox(height: 20),
                Text(
                  'Tu carrito está vacío.',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Agrega algunos productos para comenzar.',
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                ),
              ],
            )
          else
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 800,
              ),
              child: Column(
                children: [
                  ...cart.map(
                    (product) => Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            product.image,
                            width: 55,
                            height: 55,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) {
                              return const Icon(
                                Icons.checkroom,
                                color: Color(0xFF8E5AA7),
                              );
                            },
                          ),
                        ),
                        title: Text(
                          product.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'S/ ${product.price.toStringAsFixed(2)}',
                        ),
                        trailing: IconButton(
                          tooltip: 'Eliminar del carrito',
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.redAccent,
                          ),
                          onPressed: () =>
                              removeFromCart(product),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0E4F3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'TOTAL DE LA COMPRA',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'S/ ${total.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6D3F7A),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Pedido registrado correctamente. '
                                  'Gracias por comprar en GUTIPAL STYLE.',
                                ),
                                behavior:
                                    SnackBarBehavior.floating,
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.check_circle_outline,
                          ),
                          label: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 14,
                            ),
                            child: Text(
                              'REALIZAR PEDIDO',
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFF8E5AA7),
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 60),
          _footer(),
        ],
      ),
    );
  }

  // =========================
  // PIE DE PÁGINA
  // =========================

  Widget _footer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 40,
      ),
      color: const Color(0xFF2E2033),
      child: Column(
        children: [
          const Text(
            'GUTIPAL STYLE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Moda que realza tu esencia',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 15),

          // Se eliminó "Caso práctico de Hosting y Dominio"

          const SizedBox(height: 15),
          Container(
            height: 1,
            width: 250,
            color: Colors.white24,
          ),
          const SizedBox(height: 15),
          const Text(
            '© 2026 GUTIPAL STYLE - Todos los derechos reservados',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white38,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}