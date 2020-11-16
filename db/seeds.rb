# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
HqMembership.destroy_all
ProjectMembership.destroy_all
Project.destroy_all
User.destroy_all
Headquarter.destroy_all

10.times do
  headquarter = Headquarter.create!(name: Faker::Company.name, description: Faker::Lorem.paragraph)

  8.times do
    user = User.create!(name: Faker::FunnyName.two_word_name, email: Faker::Internet.unique.email, password: "mamakane")
    role = %w(owner member)
    hq_team = HeadquarterTeamAdder.new(headquarter: headquarter, user: user, role: role.sample)
    hq_team.save

    project = Project.create!(
      name: Faker::Company.name,
      url: Faker::Internet.url,
      subdomain: Faker::Internet.unique.domain_word,
      description: Faker::Lorem.paragraph,
      headquarter: headquarter
    )
    project_team = ProjectTeamAdder.new(project: project, user: user)
    project_team.save
  end
end