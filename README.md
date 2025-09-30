# Cinema Challenge - QA Automation

Automação de testes para sistema de cinema com Robot Framework.

## 🎯 Objetivo

Validar funcionalidades críticas do sistema Cinema Challenge através de testes automatizados.

## 🚀 Tecnologias

- **Robot Framework** - Framework de automação
- **BrowserLibrary** - Testes web
- **RequestsLibrary** - Testes de API
- **Python 3.13** - Linguagem base

## 📋 Funcionalidades a Serem Testadas

-  Autenticação (Login/Logout)
-  Catálogo de Filmes
-  Sessões de Cinema
-  Sistema de Reservas
-  APIs REST

## 🏗️ Estrutura do Projeto

```
cinema-challenge-qa-robotframework/
├── tests/              # Casos de teste
├── resources/          # Keywords e Page Objects
├── data/              # Dados de teste
├── docs/              # Documentação
└── reports/           # Relatórios de execução
```

## ⚡ Execução Rápida

```bash
# Instalar dependências
pip install -r requirements.txt

# Executar todos os testes
robot tests/

# Executar testes específicos
robot tests/api/
robot tests/web/
```

## 📖 Documentação

Ver [Plano de Testes](docs/test-plan.md) para detalhes completos.