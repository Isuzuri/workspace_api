# Этап 1 — Воркспейсы и участники
## Модели: 
- Workspace (name, description, owner) 
- Membership (user, workspace, role: owner/admin/member)
## Связи: 
- User has_many :memberships,
- User has_many :workspaces, through: :memberships, 
- Workspace has_many :memberships, 
- Workspace has_many :users, through: :memberships
## Контроллеры: 
- Api::V1::WorkspacesController (CRUD)
- Api::V1::MembershipsController (index, invite, remove, change_role)
## Pundit: WorkspacePolicy — только owner может удалять, все участники могут приглашать, все участники могут читать
## Роуты: вложенные resources :workspaces с resources :memberships и collection :member для remove и change_role

# Этап 2 — Проекты и задачи
## Модели: 
- Project (workspace, name, description)
- Task (project, assignee, title, description, status: todo/in_progress/done, priority: low/medium/high, deadline)
- ProjectMembership (user, project, role: owner, admin, member)
## Связи: 
- Workspace has_many :projects, 
- Project has_many :tasks, 
- Project has_many :users, through: :project_memberships
- User has_many :projects, through: :project_memberships
## Контроллеры: 
- API::V1::ProjectsController (CRUD) - вложено в workspace
- API::V1::TasksController (CRUD) - вложено в project
- API::V1::ProjectMembershipsController (index, invite, remove, change_role)
## Pundit: 
- таблица прав и ролей в miro => https://miro.com/app/board/uXjVLa8g2GA=/
## Scopes: 
- по статусу
- по приоритету
- по дедлайну
- по исполнителю

# Этап 3 — Комментарии и файлы`
## Модели: Comment (task, user, body), Attachment через Active Storage
## Связи: Task has_many :comments, Task has_many_attached :files
## Active Storage: настройка локального хранилища для dev, S3 для prod

# Этап 4 — Фоновые задачи
## Sidekiq + Redis
## Jobs: NotificationJob — уведомление при назначении задачи, DeadlineReminderJob — напоминание за 24 часа до дедлайна, InvitationMailerJob — email при приглашении в воркспейс
## Action Mailer: шаблоны писем

# Этап 5 — Поиск
## pg_search гем
## Полнотекстовый поиск по Task (title, description) и Project (name) внутри воркспейса
## Scopes через pg_search_scope, эндпоинт GET /api/v1/workspaces/:id/search?query=...

# Этап 6 — Деплой
## Railway или Render
## PostgreSQL как отдельный сервис, Redis как отдельный сервис, Sidekiq как worker
## config/environments/production.rb настройка, environment variables через dotenv, DATABASE_URL, REDIS_URL, SECRET_KEY_BASE

# Этап 7 — Фронтенд
## React + TypeScript + Vite
## Axios для запросов, JWT токен в localStorage, React Router для навигации
## Страницы: логин/регистрация, список воркспейсов, проекты воркспейса, задачи проекта, детальная страница задачи`