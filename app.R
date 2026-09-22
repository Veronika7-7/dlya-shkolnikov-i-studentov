# =========================================================
# ПРОЕКТ: "Для школьников и студентов" 🎓
# Меню: Математика | Анализ данных | Финансы
# Стиль: бирюзово-бело-синий, деловой
# Футер: от Финансового Университета
# =========================================================

library(shiny)
library(shinydashboard)

# ---------------- UI ----------------
ui <- dashboardPage(
  skin = "blue",
  
  dashboardHeader(
    title = "🎓 Для школьников и студентов",
    titleWidth = 320
  ),
  
  dashboardSidebar(
    width = 320,
    sidebarMenu(
      menuItem("📐 Математические задачи", tabName = "math", icon = icon("calculator"),
               menuSubItem("Калькулятор",           tabName = "calc"),
               menuSubItem("Квадратное уравнение",  tabName = "quad"),
               menuSubItem("Факториал",             tabName = "fact")
      ),
      menuItem("📊 Анализ данных / Статистика", tabName = "stats", icon = icon("chart-bar"),
               menuSubItem("Загрузка CSV",            tabName = "upload"),
               menuSubItem("Описательные статистики", tabName = "desc"),
               menuSubItem("Гистограмма",             tabName = "hist")
      ),
      menuItem("💼 Финансовые задачи", tabName = "fin", icon = icon("briefcase"),
               menuSubItem("Сложный процент",       tabName = "interest"),
               menuSubItem("Влияние инфляции",      tabName = "fin_infl"),
               menuSubItem("Кредитный калькулятор", tabName = "credit")
      )
    )
  ),
  
  dashboardBody(
    # ---------- СТИЛЬ (CSS) ----------
    tags$head(
      tags$style(HTML("
        /* ===== ФОН — белый с голубым отливом ===== */
        body, .content-wrapper, .right-side {
          background: linear-gradient(180deg, #FFFFFF 0%, #EAF6FA 100%) !important;
        }

        /* ===== ШАПКА — компактный заголовок, чтобы точно влез ===== */
        .skin-blue .main-header .logo {
          background: linear-gradient(90deg, #0B3C5D 0%, #1D6A96 100%) !important;
          color: #FFFFFF !important;
          font-weight: bold;
          font-size: 14px !important;
          font-family: 'Georgia', serif !important;
          letter-spacing: 0 !important;
          padding: 0 12px !important;
          line-height: 50px !important;
          white-space: nowrap !important;
          overflow: hidden !important;
          border-bottom: 3px solid #2EC4B6;
        }
        .skin-blue .main-header .logo:hover {
          background: linear-gradient(90deg, #1D6A96 0%, #0B3C5D 100%) !important;
          color: #2EC4B6 !important;
        }
        .skin-blue .main-header .navbar {
          background-color: #0B3C5D !important;
          border-bottom: 3px solid #2EC4B6;
        }

        /* ===== БОКОВОЕ МЕНЮ ===== */
        .skin-blue .main-sidebar {
          background: linear-gradient(180deg, #0B3C5D 0%, #14527A 100%) !important;
          border-right: 2px solid #2EC4B6;
        }

        .sidebar-menu > li > a {
          color: #E8F4F8 !important;
          font-size: 13px !important;
          padding: 10px 12px !important;
          line-height: 1.3 !important;
          white-space: normal !important;
          border-radius: 8px;
          margin: 4px 8px;
          font-weight: 600;
        }

        .sidebar-menu > li.active > a,
        .sidebar-menu > li:hover > a {
          background-color: rgba(46, 196, 182, 0.18) !important;
          color: #2EC4B6 !important;
          border-left: 4px solid #2EC4B6;
        }

        .sidebar-menu > li > a > .fa-angle-left,
        .sidebar-menu > li > a > .pull-right {
          display: none !important;
        }

        .sidebar-menu > li > a > .fa {
          color: #2EC4B6 !important;
          margin-right: 8px;
        }

        /* ===== ПОДПУНКТЫ ===== */
        .sidebar-menu .treeview-menu > li > a {
          font-size: 12px !important;
          padding: 8px 10px 8px 30px !important;
          color: #B8DCE8 !important;
          font-weight: 500;
          border-radius: 6px;
          margin: 2px 6px;
        }

        .sidebar-menu .treeview-menu > li.active > a,
        .sidebar-menu .treeview-menu > li > a:hover {
          background-color: rgba(46, 196, 182, 0.25) !important;
          color: #FFFFFF !important;
        }

        /* ===== КНОПКИ ===== */
        .btn-default, .btn {
          background-color: #0B3C5D !important;
          color: #FFFFFF !important;
          border: 2px solid #2EC4B6 !important;
          border-radius: 6px !important;
          font-weight: 600;
          padding: 8px 20px;
          letter-spacing: 0.5px;
          transition: all 0.2s ease;
        }
        .btn:hover {
          background-color: #2EC4B6 !important;
          color: #FFFFFF !important;
          border-color: #2EC4B6 !important;
        }

        /* ===== ЗАГОЛОВКИ ===== */
        h2 {
          color: #0B3C5D !important;
          font-weight: bold;
          font-family: 'Georgia', serif !important;
          border-bottom: 2px solid #2EC4B6;
          padding-bottom: 8px;
        }

        /* ===== ПОЛЯ ВВОДА ===== */
        .form-control {
          border-radius: 6px !important;
          border: 1px solid #B8DCE8 !important;
          background-color: #FFFFFF !important;
        }
        .form-control:focus {
          border-color: #2EC4B6 !important;
          box-shadow: 0 0 6px rgba(46, 196, 182, 0.5) !important;
        }

        /* ===== БЛОКИ С РЕЗУЛЬТАТАМИ ===== */
        .shiny-text-output, pre {
          background-color: #FFFFFF !important;
          border-radius: 6px;
          padding: 14px;
          border: 1px solid #D6EAF0;
          border-left: 4px solid #2EC4B6 !important;
          box-shadow: 0 2px 6px rgba(11, 60, 93, 0.08);
          color: #0B3C5D;
          font-family: 'Consolas', monospace;
        }

        /* ===== ТАБЛИЦЫ ===== */
        table {
          background-color: #FFFFFF !important;
          border-radius: 6px;
          box-shadow: 0 2px 6px rgba(11, 60, 93, 0.08);
        }
        table th {
          background-color: #0B3C5D !important;
          color: #2EC4B6 !important;
        }

        /* ===== ФУТЕР ===== */
        .main-footer {
          background-color: #0B3C5D !important;
          color: #2EC4B6 !important;
          border-top: 3px solid #2EC4B6 !important;
          text-align: center;
          font-family: 'Georgia', serif !important;
          letter-spacing: 1.5px;
          font-weight: 600;
        }
      "))
    ),
    
    # ---------- ОСНОВНОЙ КОНТЕНТ ----------
    tabItems(
      
      tabItem(tabName = "calc",
              h2("📐 Калькулятор"),
              numericInput("a", "Первое число", 0),
              numericInput("b", "Второе число", 0),
              selectInput("op", "Операция", c("+", "-", "*", "/")),
              actionButton("go_calc", "Вычислить"),
              verbatimTextOutput("calc_out")
      ),
      
      tabItem(tabName = "quad",
              h2("📐 Решение ax\u00B2 + bx + c = 0"),
              numericInput("qa", "a", 1),
              numericInput("qb", "b", 0),
              numericInput("qc", "c", 0),
              actionButton("go_quad", "Решить"),
              verbatimTextOutput("quad_out")
      ),
      
      tabItem(tabName = "fact",
              h2("📐 Факториал числа n!"),
              numericInput("n_fact", "Число n", 5, min = 0, step = 1),
              actionButton("go_fact", "Вычислить"),
              verbatimTextOutput("fact_out")
      ),
      
      tabItem(tabName = "upload",
              h2("📊 Загрузка CSV-файла"),
              fileInput("file", "Выберите CSV-файл"),
              tableOutput("csv_table")
      ),
      
      tabItem(tabName = "desc",
              h2("📊 Описательные статистики"),
              fileInput("file2", "Выберите CSV-файл"),
              tableOutput("desc_table")
      ),
      
      tabItem(tabName = "hist",
              h2("📊 Гистограмма"),
              fileInput("file3", "Выберите CSV-файл"),
              selectInput("hist_col", "Столбец", choices = NULL),
              plotOutput("hist_plot")
      ),
      
      tabItem(tabName = "interest",
              h2("💼 Сложный процент"),
              numericInput("sum_start", "Начальная сумма", 10000),numericInput("rate", "Ставка, % в год", 10),
              numericInput("years", "Срок, лет", 5),
              actionButton("go_interest", "Рассчитать"),
              verbatimTextOutput("interest_out")
      ),
      
      tabItem(tabName = "fin_infl",
              h2("💼 Влияние инфляции"),
              numericInput("money", "Сумма:", 100000),
              numericInput("infl", "Инфляция, % в год:", 8),
              numericInput("infl_years", "Лет:", 5),
              actionButton("go_infl", "Рассчитать"),
              verbatimTextOutput("infl_out")
      ),
      
      tabItem(tabName = "credit",
              h2("💼 Кредитный калькулятор"),
              numericInput("credit_sum", "Сумма кредита", 500000),
              numericInput("credit_rate", "Ставка, % в год", 15),
              numericInput("credit_years", "Срок, лет", 3),
              actionButton("go_credit", "Рассчитать"),
              verbatimTextOutput("credit_out")
      )
    ),
    
    # ---------- ФУТЕР ВНИЗУ ----------
    tags$footer(
      "🎓 от Финансового Университета",
      style = "position: fixed; bottom: 0; left: 320px; right: 0;
               background-color: #0B3C5D;
               color: #2EC4B6;
               border-top: 3px solid #2EC4B6;
               text-align: center;
               padding: 12px 0;
               font-family: 'Georgia', serif;
               letter-spacing: 1.5px;
               font-weight: 600;
               z-index: 1000;"
    )
  )
)

# ---------------- SERVER ----------------
server <- function(input, output, session) {
  
  observeEvent(input$go_calc, {
    res <- switch(input$op,
                  "+" = input$a + input$b,
                  "-" = input$a - input$b,
                  "*" = input$a * input$b,
                  "/" = if (input$b == 0) "Деление на ноль!" else input$a / input$b
    )
    output$calc_out <- renderPrint(res)
  })
  
  observeEvent(input$go_quad, {
    a <- input$qa; b <- input$qb; c <- input$qc
    if (a == 0) {
      output$quad_out <- renderPrint("Это не квадратное уравнение (a = 0)")
      return()
    }
    D <- b^2 - 4 * a * c
    if (D > 0) {
      x1 <- (-b + sqrt(D)) / (2 * a)
      x2 <- (-b - sqrt(D)) / (2 * a)
      output$quad_out <- renderPrint({
        cat("Дискриминант D =", D, "\n")
        cat("x1 =", x1, "| x2 =", x2, "\n")
      })
    } else if (D == 0) {
      output$quad_out <- renderPrint({
        cat("Дискриминант D =", D, "\n")
        cat("x =", -b / (2 * a), "\n")
      })
    } else {
      output$quad_out <- renderPrint({
        cat("Дискриминант D =", D, "\n")
        cat("Корней нет\n")
      })
    }
  })
  
  observeEvent(input$go_fact, {
    n <- input$n_fact
    if (n < 0 || n != round(n)) {
      output$fact_out <- renderPrint("Нужно целое неотрицательное число")
    } else {
      output$fact_out <- renderPrint(paste(n, "! =", factorial(n)))
    }
  })
  
  output$csv_table <- renderTable({
    req(input$file)
    read.csv(input$file$datapath)
  })
  
  output$desc_table <- renderTable({
    req(input$file2)
    df <- read.csv(input$file2$datapath)
    stat_one <- function(x, fun) {
      if (is.numeric(x)) round(fun(x, na.rm = TRUE), 2) else NA
    }
    data.frame(
      Переменная = names(df),
      Среднее    = sapply(df, stat_one, fun = mean),
      Медиана    = sapply(df, stat_one, fun = median),
      Мин        = sapply(df, stat_one, fun = min),
      Макс       = sapply(df, stat_one, fun = max),
      stringsAsFactors = FALSE
    )
  })
  
  observeEvent(input$file3, {
    df <- read.csv(input$file3$datapath)
    num_cols <- names(df)[sapply(df, is.numeric)]
    updateSelectInput(session, "hist_col", choices = num_cols)
  })
  
  output$hist_plot <- renderPlot({
    req(input$file3, input$hist_col)
    df <- read.csv(input$file3$datapath)
    hist(df[[input$hist_col]],
         main = paste("Распределение:", input$hist_col),
         xlab = input$hist_col,
         col = "#2EC4B6",
         border = "#0B3C5D")
  })
  
  observeEvent(input$go_interest, {
    P <- input$sum_start
    r <- input$rate / 100
    t <- input$years
    S <- P * (1 + r)^t
    output$interest_out <- renderPrint({cat("Начальная сумма:", P, "\n")
      cat("Ставка:", input$rate, "% годовых\n")
      cat("Срок:", t, "лет\n")
      cat("Итоговая сумма:", round(S, 2), "\n")
      cat("Прибыль:", round(S - P, 2), "\n")
    })
  })
  
  observeEvent(input$go_infl, {
    money <- input$money
    infl <- input$infl / 100
    years <- input$infl_years
    real <- money / (1 + infl)^years
    output$infl_out <- renderPrint({
      cat("Номинал:", money, "\n")
      cat("Инфляция:", input$infl, "% в год\n")
      cat("Через", years, "лет реальная покупательная способность:", round(real, 2), "\n")
      cat("Потери:", round(money - real, 2), "\n")
    })
  })
  
  observeEvent(input$go_credit, {
    S <- input$credit_sum
    r <- input$credit_rate / 100 / 12
    n <- input$credit_years * 12
    pay <- S * r / (1 - (1 + r)^-n)
    total <- pay * n
    output$credit_out <- renderPrint({
      cat("Сумма кредита:", S, "\n")
      cat("Ставка:", input$credit_rate, "% годовых\n")
      cat("Срок:", input$credit_years, "лет\n")
      cat("Ежемесячный платёж:", round(pay, 2), "\n")
      cat("Всего выплат:", round(total, 2), "\n")
      cat("Переплата:", round(total - S, 2), "\n")
    })
  })
}

# ---------------- ЗАПУСК ----------------
shinyApp(ui, server)