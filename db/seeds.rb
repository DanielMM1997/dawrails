# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'

file = File.read('app\app\assets\backgrounds.json')

User.create({:nickname => "admin", :email => "admin@gmail.com", :password => "Admin123456789", :type => 1})
User.create({:nickname => "moderador", :email => "moderador@gmail.com", :password => "Moderador123456789", :type => 2})
User.create({:nickname => "pepemel", :email => "pepemel@gmail.com", :password => "Pepemel1", :type => 3})

Category.create([
    { :name => 'Animales' }, 
    { :name => 'Paisajes' }, 
    { :name => 'Universo' }, 
    { :name => 'Ciudades' }, 
    { :name => 'Coches' }, 
    { :name => 'Motos' }, 
    { :name => 'Aviones' }, 
    { :name => 'Fútbol' },
    { :name => 'Baloncesto' }, 
    { :name => 'Tenis' }])

datos = JSON.parse(file)
backgrounds = datos['backgrounds']

i = 0

backgrounds.each do |background|
    i = i+1
    user_id = 1
    if i.between?(41, 62)
        user_id = 2
    end
    Background.create({
        :title => background[0]["title"],
        :path => background[0]["url"],
        :tags => background[0]["tags"],
        :author_id => user_id
    })

    #Categoría: animales
    if i.between?(1, 20)
        BackgroundCategory.create([{ :background_id => i, :category_id => 1 }])
        Like.create([{ :background_id => i, :user_id => 1 }])
    end

    #Categoría: paisajes
    if i.between?(21, 40)
        BackgroundCategory.create([{ :background_id => i, :category_id => 2 }])
    elsif i.between?(95, 97)
        BackgroundCategory.create([{ :background_id => i, :category_id => 2 }])
    elsif i.between?(116, 117)
        BackgroundCategory.create([{ :background_id => i, :category_id => 2 }])
    elsif i.between?(138, 141)
        BackgroundCategory.create([{ :background_id => i, :category_id => 2 }])
    elsif i.between?(164, 165)
        BackgroundCategory.create([{ :background_id => i, :category_id => 2 }])
    elsif (i === 52 or i === 185)
        BackgroundCategory.create([{ :background_id => i, :category_id => 2 }])
    end

    #Categoría: universo
    if i.between?(41, 62)
        BackgroundCategory.create([{ :background_id => i, :category_id => 3 }])
    elsif (i === 19)
        BackgroundCategory.create([{ :background_id => i, :category_id => 3 }])
    end

    #Categoría: ciudades
    if i.between?(63, 82)
        BackgroundCategory.create([{ :background_id => i, :category_id => 4 }])
    elsif i.between?(85, 86)
        BackgroundCategory.create([{ :background_id => i, :category_id => 4 }])
    elsif (i === 109 or i === 127 or i === 198)
        BackgroundCategory.create([{ :background_id => i, :category_id => 4 }])
    end

    #Categoría: coches
    if i.between?(83, 101)
        BackgroundCategory.create([{ :background_id => i, :category_id => 5 }])
    elsif i.between?(85, 86)
        BackgroundCategory.create([{ :background_id => i, :category_id => 5 }])
    elsif (i === 110 or i === 128 or i === 164)
        BackgroundCategory.create([{ :background_id => i, :category_id => 5 }])
    end

    #Categoría: motos
    if i.between?(102, 121)
        BackgroundCategory.create([{ :background_id => i, :category_id => 6 }])
    end

    #Categoría: aviones
    if i.between?(122, 143)
        BackgroundCategory.create([{ :background_id => i, :category_id => 7 }])
    end

    #Categoría: futbol
    if i.between?(144, 163)
        BackgroundCategory.create([{ :background_id => i, :category_id => 8 }])
    end

    #Categoría: baloncesto
    if i.between?(166, 170)
        BackgroundCategory.create([{ :background_id => i, :category_id => 9 }])
    end

    #Categoría: tenis
    if i.between?(171, 175)
        BackgroundCategory.create([{ :background_id => i, :category_id => 10 }])
    end

end