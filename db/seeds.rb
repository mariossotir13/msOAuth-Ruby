# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
client = Client.create(
    app_title: 'Demo 1',
    client_type: ClientType::CONFIDENTIAL,
    redirection_uri: 'https://msoauthruby.local/demo1',
    id: '6Y7wYCWSzKQHz23YdPIxwjcbpq2NEY6xZXvo0FpB8W0',
    email: 'demo1@client.com',
    password: 'G6icA3Y2AJuyw1EZZbBMWh0tp984QO69YvYW5b5e3J3wEtzBzHZvVTZ3YoLZRgrU'
)

resource_owner = ResourceOwner.create(
    id: 'Resource Owner Demo 1',
    email: 'demo1@resourceowner.com',
    password: '/3U/51Yj3OLc5QjU3qBMjK8XIYWeBwsc5ftCSwDkWX/DaRiUAyvRYdN6a8ALwjfwYyUvmfjfhsfGkOneZe62WA==',
    salt: 'TzqIyVkrVRTIYQ=='
)

scope = AuthorizationCodeScope.create(
    title: AuthorizationCodeScope::BASIC,
    description: 'Δικαίωμα πρόσβασης στους πόρους μόνο για ανάγνωση.'
)