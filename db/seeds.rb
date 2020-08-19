require "pry"
Exercise.destroy_all
Exercise.reset_pk_sequence
Lifter.destroy_all
Lifter.reset_pk_sequence
ExerciseLog.destroy_all
ExerciseLog.reset_pk_sequence



#seed data for Lifter and Exercise; I will start by creating 3 instances of lifter and setting up exercises for them
josh = "Josh the Power Lifter"

josh_exercises = [ #just keep it simple for now
    {
        name:"Bench Press",
        target_muscle_group: "chest",
        weight_in_pounds: 300,
        reps:5
    },
    {
        name:"Deadlift",
        target_muscle_group: "lower back",
        weight_in_pounds: 350,
        reps:5
    },
    {
        name:"Barbell Rows",
        target_muscle_group: "upper back",
        weight_in_pounds: 200,
        reps:5
    },
    {
        name: "Barbell Squats",
        target_muscle_group: "legs",
        weight_in_pounds:275,
        reps:5
    }
]

patrick = "Patrick the fitness enthusiast"

patrick_exercises = [ 
{
    name:"Weighted Pull up",
    target_muscle_group: "chest",
    weight_in_pounds: 200,
    reps:8,
},
{
    name:"Weighted Dips",
    target_muscle_group: "triceps",
    weight_in_pounds: 200,
    reps:8
},
{
    name:"Barbell Rows",
    target_muscle_group: "upper back",
    weight_in_pounds: 165,
    reps:8
},
{
    name: " Barbell Squats",
    target_muscle_group: "legs",
    weight_in_pounds: 225,
    reps:8
}
]

john = "John the amateur"

john_exercises = [ #just keep it simple for now
{
    name:"Dumbell press",
    target_muscle_group: "chest",
    weight_in_pounds:60,
    reps:2,
},
{
    name:"Deadlift",
    target_muscle_group: "lower back",
    weight_in_pounds:80,
    reps:2
},
{
    name:"Lat Pulldown",
    target_muscle_group: "upper back",
    weight_in_pounds:25,
    reps:8
},
{
    name: "Body Squat",
    target_muscle_group: "legs",
    weight_in_pounds:120,
    reps:5
}
]

#Now I need to create a few mwthods that can help me dynamically add things to my database
#the good thing about doing it this way is that I can reuse the code in all my model files for new users

#helper methods for my #add_lifter_and_exercise_to_log
def create_lifter_instance(name)
    lifter = Lifter.create(name:name)
    lifter
end #this works

def create_exercise_instance(exercise_info_hash)
    exercise = Exercise.create(
        name:exercise_info_hash[:name],
        target_muscle_group:exercise_info_hash[:target_muscle_group],
        weight_in_pounds:exercise_info_hash[:weight_in_pounds],
        reps:exercise_info_hash[:reps])
    exercise
end #this works


#this method takes in a lifter, an array of exercises, a maximum
def add_lifter_and_exercise_to_log(lifter_name_string, exercise_info_hash)
    if !Lifter.find_by(name:lifter_name_string)
        lifter = create_lifter_instance(lifter_name_string)
    else
        lifter = Lifter.find_by(name:lifter_name_string)
    end   
    exercise = create_exercise_instance(exercise_info_hash)

    new_exercise_log = ExerciseLog.new(date_and_time:DateTime.new(2020,8,16))
    lifter_check = lifter.exercise_logs.push(new_exercise_log)
    exercise_check = exercise.exercise_logs.push(new_exercise_log)



end


#--------------------------------------------------------------------------------------------------------------------#

#so much work but now I can populate my database and I have the CRUD implementation to create a new Lifter and Exercise

josh_exercises.each{|exercise|add_lifter_and_exercise_to_log(josh,exercise)}
patrick_exercises.each{|exercise|add_lifter_and_exercise_to_log(patrick,exercise)}
john_exercises.each{|exercise|add_lifter_and_exercise_to_log(john,exercise)}

binding.pry


# #josh's exercises
# #exercise 1
# add_lifter_and_exercise_to_log(josh,{
#     name:"Bench Press",
#     target_muscle_group: "chest",
#     weight_in_pounds: 300,
#     reps:5
# })

# #exercise 2

# add_lifter_and_exercise_to_log(josh,{
#     name:"Deadlift",
#     target_muscle_group: "lower back",
#     weight_in_pounds: 350,
#     reps:5
# })

# #exercise 3
# add_lifter_and_exercise_to_log(josh,{
#     name:"Barbell Rows",
#     target_muscle_group: "upper back",
#     weight_in_pounds: 200,
#     reps:5
# })

# #exercise 4
# add_lifter_and_exercise_to_log(josh,{
#     name: "Barbell Squats",
#     target_muscle_group: "legs",
#     weight_in_pounds:275,
#     reps:5
# })

binding.pry



puts "I have successfully seeded our database with fresh data"
#--------------------------------------------------------------------------------------#

# Plant.destroy_all
# Person.destroy_all
# PlantParenthood.destroy_all
# Plant.reset_pk_sequence
# Person.reset_pk_sequence
# PlantParenthood.reset_pk_sequence







# ########### different ways to write your seeds ############







# # 1: save everything to variables (makes it easy to connect models, best for when you want to be intentional about your seeds)
# basil = Plant.create(name: "basil the herb", bought: 20200610, color: "green")
# sylwia = Person.create(name: "Sylwia", free_time: "none", age: 30)
# pp1 = PlantParenthood.create(plant_id: basil.id, person_id: sylwia.id, affection: 1_000_000, favorite?: true)

# # 2. Mass create -- in order to connect them later IN SEEDS (not through the app) you'll need to find their id
# ## a. by passing an array of hashes:







# Plant.create([
#     {name: "Corn Tree", bought: 20170203, color: "green"},
#     {name: "Prayer plant", bought: 20190815, color: "purple"},
#     {name: "Cactus", bought: 20200110, color: "ugly green"}
# ])
# ## b. by interating over an array of hashes:
# plants = [{name: "Elephant bush", bought: 20180908, color: "green"},
#     {name: "Photos", bought: 20170910, color: "green"},
#     {name: "Dragon tree", bought: 20170910, color: "green"},
#     {name: "Snake plant", bought: 20170910, color: "dark green"},
#     {name: "polka dot plant", bought: 20170915, color: "pink and green"},
#     {name: "Cactus", bought: 20200517, color: "green"}]

# plants.each{|hash| Plant.create(hash)}






# # 3. Use Faker and mass create
# ## step 1: write a method that creates a person
# def create_person
#     free = ["mornings", "evenings", "always", "afternoons", "weekends", "none"].sample

#     person = Person.create(
#         name: Faker::Movies::HitchhikersGuideToTheGalaxy.character,
#         free_time: free,
#         age: rand(11...70)
#     )
# end

# ## step 2: write a method that creates a joiner
# def create_joiners(person)
#     plants_number = rand(1..4)
#     plants_number.times do 
#         PlantParenthood.create(
#             plant_id: Plant.all.sample.id, 
#             person_id: person.id, 
#             affection: rand(101), 
#             favorite?: [true, false].sample
#         )
#     end
# end

# ## step 3: invoke creating joiners by passing in an instance of a person
# 10.times do     
#     create_joiners(create_person)
#     ##### ALTERNATIVE:
#     # person = create_person
#     # create_joiners(person)
# end

# indoor = Category.create(name: "indoors")

# Plant.update(category_id: indoor.id)


