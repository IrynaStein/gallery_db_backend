Artwork.destroy_all
Category.destroy_all
Collector.destroy_all
Collection.destroy_all


puts "Seeding Categories ..."

cat1 = Category.create(name: "superheroes", popularity: 0)
cat2 = Category.create(name: "pop-culture", popularity: 0)
cat3 = Category.create(name: "flowers", popularity: 0)
cat4 = Category.create(name: "abstract", popularity: 0)
cat5 = Category.create(name: "yoga", popularity: 0)

puts "Seeding artworks ..."

art1 = Artwork.create(
    title: "Super Man",
    edition: 5,
    likes: 197,
    price: 100,
    medium: "Multicolor digital print. Produced on archival, acid-free heavy weight paper. Hand signed and numbered in lower right corner. Certificate of authenticity. Unframed",
    image: "https://live.staticflickr.com/65535/51288355963_063bc6a03c_c.jpg ",
    featured: true,
    date_created: 2021,
    category: cat1
)

art2 = Artwork.create(
    title: "Blue Hydragnea",
    edition: 10,
    likes: 58,
    price: 45,
    medium: "Multicolor digital print. Produced on archival, acid-free heavy weight paper. Hand signed and numbered in lower right corner. Certificate of authenticity. Unframed",
    image: "https://live.staticflickr.com/65535/51288905519_c090bc8f56_c.jpg",
    featured: false,
    date_created: 2019,
    category: cat3
)

art3 = Artwork.create(
    title: "Mario",
    edition: 25,
    likes: 17,
    price: 45,
    medium: "Multicolor digital print. Produced on archival, acid-free heavy weight paper. Hand signed and numbered in lower right corner. Certificate of authenticity. Unframed",
    image: "https://live.staticflickr.com/65535/51289198000_ca5236019a_c.jpg",
    featured: false,
    date_created: 2020,
    category: cat2
)


puts "Seeding collectors ..."

3.times do
    Collector.create(
        first_name: Faker::Name.first_name, 
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        full_address: Faker::Address.full_address,
        phone_num: Faker::PhoneNumber.cell_phone
    )
end

puts "Seeding collections...."

Collection.create(artwork: art1, collector_id: rand(1..3))