# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CollegeTracker.Repo.insert!(%CollegeTracker.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias CollegeTracker.ExtracurricularActivities.ActivityCategory
alias CollegeTracker.Repo

# Insert activity categories
Repo.insert!(%ActivityCategory{name: "Palestras e Eventos", limit: 50})
Repo.insert!(%ActivityCategory{name: "Cursos e Estudos do Meio", limit: 50})
Repo.insert!(%ActivityCategory{name: "Atividades e Práticas Profissionais", limit: 60})
