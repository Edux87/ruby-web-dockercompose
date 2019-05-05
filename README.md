# README

### 1. PREVIAMENTE

    # Generar un proyecto nuevo
    rails new .

    # Recordar cambiar la version sqlite3
    
    # Editar Gemfile y reemplazar
    gem 'sqlite3', '~> 1.3.13'
    
    # Actualizar las dependencias
    bundle install
    
#### 1.1 Crearemos el metodo Home en el controlador Application

    #Generar un controller
    rails generate controller Application home
    
    
    # Verificar archivo: /app/controllers/application_controller.rb
    class ApplicationController < ActionController::Base
      def home
        render html: "Hola Mundo!"
      end
    end

#### 1.2 Configuramos la ruta por defecto
    # Archivo: config/routes.rb
    Rails.application.routes.draw do
      root "application#home"
    end
    
#### 1.3 Levanta el servidor

    rails s
    
    # Eventualmente si sale error ejecutar esta alternativa
    bundle exec rails s -p 3000 -b '0.0.0.0'


### 2. AUTHENTICATION
#### 2.1 Instalar las dependencias

    # Editar Gemfile y agregar al final
    gem 'devise', '~> 4.5.0'
    
    # luego actualizar nuevamente las dependencias
    bundle install
    
#### 2.2 Setup devise

    # Ejecutar esto
    rails g devise:install
    
    # Para personalizar las vistas ejecutamos
    rails g devise:views

#### 2.2 Setup Model
    
    # Crear Modelos y migrarlo a la BD
    rails g devise user
    rails db:migrate
    
    # Agregar en routes.rb
    devise_for :users, controllers: {registrations: 'registrations'}
    
    # Reinicia tu servidor
    # Ya tienes authentication pero no lo tienes asignado a ningun controlador aún asi puedes ver las rutas
    rails routes
    
    # puedes probar
    http://localhost:3000/users/sign_up
    http://localhost:3000/users/sign_in
    
    # Para ver otras rutas ejecutar
    rails routes
    
*Si no vas a crear ningun campo adicional*, entonces ya ve creando tu usuario admin y pasate al punto 3, pero **si vas a crear campos personalizados** entonces ***NO CREES NADA***, y continua con el siguiente punto.

#### 2.3 Agregar Campos al Devise
    
    # Generamos una migracion, cheka que al final se agrega el campo, puedes agregar varios en un solo migrate
    rails generate migration add_name_to_users name:string
    
    # Revisa el migrate. la ruta es algo como esto
    db/migrate/20190505051825_add_name_to_users.rb
    
    # Ejecuta el migrate
    rake db:migrate
    
    == 20190505051825 AddNameToUsers: migrating ===================================
    -- add_column(:users, :name, :string)
       -> 0.0015s
    == 20190505051825 AddNameToUsers: migrated (0.0025s) ==========================
    
    # Ahora actualiza las vistas en donde se requiera ingresar el o los campos nuevos
    # En el archivo app/views/devise/registrations/new.html.erb, agrega el o los campos que creaste.
    <div class="field">
      <%= f.label :name %><br />
      <%= f.text_field :name %>
    </div>      
    
#### 2.4 Generando Links

    <% if user_signed_in? %>
      Logged in as <strong><%= current_user.email %></strong>.
      <%= link_to 'Edit profile', edit_user_registration_path, :class => 'navbar-link' %> |
      <%= button_to "Logout", destroy_user_session_path, method: :delete, :class => 'navbar-link'  %>
    <% else %>
      <%= link_to "Sign up", new_user_registration_path, :class => 'navbar-link'  %> |
      <%= link_to "Login", new_user_session_path, :class => 'navbar-link'  %>
    </p>
    <% end %>
    
### 3. Implementar Scaffold
#### 3.1 Generando modelos

    # Voy a crear el modelo de productos
    # Si usas linux con terminal ZSH usar decimal{8-2}
    rails generate scaffold Producto nombre:string precio:decimal{8,2} categoria_id:integer
    
    # Voy a crear el modelo de categorias
    rails generate scaffold Categoria nombre:string desc:text
    
    # Ejecutar la migracion
    rake db:migrate
    
    == 20190505055741 CreateCategoria: migrating ==================================
    -- create_table(:categoria)
       -> 0.0027s
    == 20190505055741 CreateCategoria: migrated (0.0029s) =========================

    == 20190505055940 CreateProductos: migrating ==================================
    -- create_table(:productos)
       -> 0.0022s
    == 20190505055940 CreateProductos: migrated (0.0024s) =========================
    
#### 3.1 Scaffold dentro de Devise
    
    # Colocar los siguientes links
    <%= link_to "Categorias", "categoria#index", :class => 'navbar-link'  %>
    <%= link_to "Productos", "productos#index", :class => 'navbar-link'  %>
    
    # Exigir usuario authenticated, colocar esto en cada controlador de scaffold
    before_action :authenticate_user!
    
    