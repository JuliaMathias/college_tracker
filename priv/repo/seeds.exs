# priv/repo/seeds.exs

alias CollegeTracker.ExtracurricularActivities.ActivityCategory
alias CollegeTracker.ExtracurricularActivities.ActivityType
alias CollegeTracker.Repo

insert_activity_type = fn category_id, {name, total_limit, individual_limit} ->
  Repo.insert!(%ActivityType{
    name: name,
    total_limit: total_limit,
    individual_limit: individual_limit,
    remaining_limit: total_limit,
    status: :available,
    activity_category_id: category_id
  })
end

if Mix.env() != :test do
  # Insert activity categories
  palestras_e_eventos = Repo.insert!(%ActivityCategory{name: "Palestras e Eventos", limit: 50})

  cursos_e_estudos_do_meio =
    Repo.insert!(%ActivityCategory{name: "Cursos e Estudos do Meio", limit: 50})

  atividades_e_praticas_profissionais =
    Repo.insert!(%ActivityCategory{name: "Atividades e Práticas Profissionais", limit: 60})

  # Activity types for each category
  palestras_activity_types = [
    {"Congresso (ouvinte / apresentação de trabalho)", 20, 5},
    {"Palestra", 20, 2},
    {"Presença em Defesa de Dissertação e Tese", 20, 2},
    {"Semana Profissional", 20, 5},
    {"Desenvolvimento e Apresentação de Trabalho de Iniciação Científica", 20, 4},
    {"Outros (depende de aprovação)", 20, 1}
  ]

  cursos_activity_types = [
    {"Curso da Área", 30, 5},
    {"Visita Orientada à Espaços Externos Significativos", 20, 4},
    {"Curso de Línguas ou de Especializações na Área (ao menos 100h)", 20, 20},
    {"Outros (depende de aprovação)", 20, 1}
  ]

  atividades_activity_types = [
    {"Atividade de Monitoria na Faculdade", 20, 6},
    {"Atividade de Monitoria Externa", 20, 5},
    {"Atividade de Estágio não obrigatório (ao menos 100h)", 30, 30},
    {"Trabalho Voluntário na Área (ao menos 100h)", 20, 20},
    {"Atuação Profissional na Área (ao menos 100h)", 30, 30},
    {"Outros (depende de aprovação)", 20, 1}
  ]

  # Insert activity types
  Enum.each(palestras_activity_types, &insert_activity_type.(palestras_e_eventos.id, &1))
  Enum.each(cursos_activity_types, &insert_activity_type.(cursos_e_estudos_do_meio.id, &1))

  Enum.each(
    atividades_activity_types,
    &insert_activity_type.(atividades_e_praticas_profissionais.id, &1)
  )
end
