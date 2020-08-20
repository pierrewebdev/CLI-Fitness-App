
Exercise.destroy_all
Exercise.reset_pk_sequence
Lifter.destroy_all
Lifter.reset_pk_sequence
ExerciseLog.destroy_all
ExerciseLog.reset_pk_sequence
PersonalRecord.destroy_all
PersonalRecord. reset_pk_sequence



#seed data for Lifter and Exercise; I will start by creating 3 instances of lifter and setting up exercises for them
josh = "josh"

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
        reps:10
    },
    {
        name:"Barbell Rows",
        target_muscle_group: "upper back",
        weight_in_pounds: 200,
        reps:15
    },
    {
        name: "Barbell Squats",
        target_muscle_group: "legs",
        weight_in_pounds:275,
        reps:20
    }
]

patrick = "patrick"

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
    name: "Barbell Squats",
    target_muscle_group: "legs",
    weight_in_pounds: 225,
    reps:8
}
]

john = "john"

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

asha = "asha"

asha_exercises = [
    {
        name:"Glute Bridges",
        target_muscle_group:"glutes",
        weight_in_pounds: 45,
        reps:10
    },
    {
        name:"Body Squat",
        target_muscle_group:"legs",
        weight_in_pounds:120, #this is supposed to test if two lifters can have the same exercise
        reps:5
    },
    {
    name:"Deadlift",
    target_muscle_group: "lower back",
    weight_in_pounds:80,
    reps:2
    },
    {
        name:"Weighted Lunges",
        target_muscle_group:"legs",
        weight_in_pounds:25,
        reps:15
    },
    {
        name:"Barbell Rows",
        target_muscle_group:"upper back",
        weight_in_pounds:70,
        reps:8
    }

]



#--------------------------------------------------------------------------------------------------------------------#

#so much work but now I can populate my database and I have the CRUD implementation to create a new Lifter and Exercise

josh_exercises.each{|exercise|ExerciseLog.add_lifter_and_exercise_to_log(josh,exercise)}
# josh_exercises.each do |exercise| #I'm creating a new pr for each exercise
#     exercise_instance = Exercise.find_by(name:exercise[:name])
#     logged_exercise_instance = ExerciseLog.find_by(exercise_id:exercise_instance.id)
#     PersonalRecord.create(exercise_log_id:logged_exercise_instance[:id],max_rep_count:logged_exercise_instance.exercise.reps,max_weight:logged_exercise_instance.exercise.weight_in_pounds)
# end

patrick_exercises.each{|exercise|ExerciseLog.add_lifter_and_exercise_to_log(patrick,exercise)}
# patrick_exercises.each do |exercise| #I'm creating a new pr for each exercise
#     exercise_instance = Exercise.find_by(name:exercise[:name])
#     logged_exercise_instance = ExerciseLog.find_by(exercise_id:exercise_instance.id)
#     PersonalRecord.create(exercise_log_id:logged_exercise_instance[:id],max_rep_count:logged_exercise_instance.exercise.reps,max_weight:logged_exercise_instance.exercise.weight_in_pounds)
# end


john_exercises.each{|exercise|ExerciseLog.add_lifter_and_exercise_to_log(john,exercise)}
# john_exercises.each do |exercise| #I'm creating a new pr for each exercise
#     exercise_instance = Exercise.find_by(name:exercise[:name])
#     logged_exercise_instance = ExerciseLog.find_by(exercise_id:exercise_instance.id)
#     PersonalRecord.create(exercise_log_id:logged_exercise_instance[:id],max_rep_count:logged_exercise_instance.exercise.reps,max_weight:logged_exercise_instance.exercise.weight_in_pounds)
# end

asha_exercises.each{|exercise|ExerciseLog.add_lifter_and_exercise_to_log(asha,exercise)}
# asha_exercises.each do |exercise| #I'm creating a new pr for each exercise
#     exercise_instance = Exercise.find_by(name:exercise[:name])
#     logged_exercise_instance = ExerciseLog.find_by(exercise_id:exercise_instance.id)
#     PersonalRecord.create(exercise_log_id:logged_exercise_instance[:id],max_rep_count:logged_exercise_instance.exercise.reps,max_weight:logged_exercise_instance.exercise.weight_in_pounds)
# end


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


