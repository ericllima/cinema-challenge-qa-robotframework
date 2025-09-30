# PLANO DE TESTE - CINEMA CHALLENGE

## APRESENTAÇÃO
Este documento apresenta o plano de testes para o sistema Cinema Challenge, desenvolvido como parte do desafio técnico final do PB AWS & AI for QE. O projeto abrange a automação de testes para uma aplicação completa de cinema com funcionalidades de reserva de ingressos, utilizando Robot Framework como ferramenta principal de automação.

## EQUIPE ENVOLVIDA
- **QA Engineer**: [Eric Lima](https://github.com/ericllima) Responsável pelo planejamento, análise e automação dos testes
- **Squad**: Level UP

## OBJETIVO
Validar a qualidade e funcionalidade do sistema Cinema Challenge através de testes automatizados essenciais, garantindo que as funcionalidades críticas funcionem conforme especificado e proporcionem uma experiência de usuário satisfatória.

## ESCOPO

### Funcionalidades Incluídas:
- **Autenticação**: Registro, login, logout e gerenciamento de perfil
- **Gerenciamento de Filmes**: Visualização de catálogo e detalhes
- **Sessões**: Consulta de horários e disponibilidade
- **Reservas**: Seleção de assentos, checkout e histórico
- **Navegação**: Interface responsiva e experiência do usuário

### Funcionalidades Excluídas:

- Integração com sistemas externos de terceiros
- Funcionalidades administrativas avançadas

## USER STORIES

### Módulo Autenticação (4 User Stories)
- **US-AUTH-001**: Registro de usuário com validações de e-mail e senha
- **US-AUTH-002**: Login com autenticação e redirecionamento
- **US-AUTH-003**: Logout com limpeza de sessão e tokens
- **US-AUTH-004**: Gerenciamento de perfil com edição de dados

### Módulo Filmes (3 User Stories)
- **US-HOME-001**: Página inicial atrativa com banner e responsividade
- **US-MOVIE-001**: Navegação no catálogo com grid responsivo
- **US-MOVIE-002**: Visualização de detalhes com sinopse e sessões

### Módulo Sessões (1 User Story)
- **US-SESSION-001**: Consulta de horários com disponibilidade em tempo real

### Módulo Reservas (3 User Stories)
- **US-RESERVE-001**: Seleção de assentos com validação de disponibilidade
- **US-RESERVE-002**: Processo de checkout
- **US-RESERVE-003**: Histórico de reservas com status e detalhes

### Módulo UX/Navegação (1 User Story)
- **US-NAV-001**: Navegação intuitiva com menu responsivo

## ANÁLISE

### Análise de Risco
| Funcionalidade | Complexidade | Impacto | Probabilidade | Risco |
|--------------|--------------|---------|---------------|-------|
| Sistema de Reservas | Alta | Alto | Médio | Alto |
| Autenticação | Média | Alto | Baixo | Médio |
| Interface Responsiva | Média | Médio | Médio | Médio |
| Catálogo de Filmes | Baixa | Médio | Baixo | Baixo |

### Critérios de Entrada
- Ambiente de desenvolvimento configurado
- APIs do backend funcionais
- Frontend acessível
- Dados de teste preparados
- Ferramentas de automação instaladas

### Critérios de Saída
- 100% dos testes críticos executados com sucesso
- Cobertura mínima de 60% das funcionalidades essenciais
- Zero bugs críticos em aberto
- Relatórios de teste gerados e aprovados
- Entrega em 2 semanas

## TÉCNICAS APLICADAS

### Técnicas de Teste Funcional
- **Partição de Equivalência**: Validação de campos de entrada (e-mail, senha, dados pessoais)
- **Análise de Valor Limite**: Testes de limites em durações de filmes e datas de sessão
- **Teste de Estado**: Fluxos de autenticação e estados de reserva
- **Teste de Usabilidade**: Navegação e experiência do usuário em diferentes dispositivos

### Técnicas de Automação
- **Page Object Model (POM)**: Organização de elementos de interface
- **Service Objects**: Abstração de chamadas de API REST
- **Data-Driven Testing**: Cenários com múltiplos conjuntos de dados
- **Keywords Reutilizáveis**: Maximização de reuso de código

## MAPA MENTAL DA APLICAÇÃO


## CRONOGRAMA DE EXECUÇÃO 

### Dias 1-2: Setup e Fundação
- Configuração do ambiente Robot Framework
- Estrutura básica de Page Objects
- Keywords de autenticação essenciais

### Dias 3-4: Testes Críticos (Prioridade 1)
- Implementação dos 4 cenários de ROI Alto
- Testes de login/logout
- Fluxo básico de reserva

### Dias 5-6: Testes de API Essenciais
- 8 cenários críticos de API
- Validação de endpoints principais

### Dias 7-8: Testes de Interface Básicos
- 6 cenários de interface críticos
- Fluxos de usuário essenciais

### Dias 9-10: Integração e Entrega
- 2-3 testes end-to-end
- Relatórios e documentação

## CENÁRIOS DE TESTE REDUZIDOS - ESCOPO

### Testes de API (Backend) - 8 Cenários Essenciais
#### Autenticação (2 cenários)
- Login com credenciais válidas
- Login com credenciais inválidas

#### Filmes (2 cenários)
- Listagem de todos os filmes
- Busca de filme por ID válido

#### Sessões (2 cenários)
- Listagem de sessões por filme
- Validação de horários disponíveis

#### Reservas (2 cenários)
- Criação de reserva válida
- Listagem de reservas por usuário

### Testes de Interface (Frontend) - 6 Cenários Críticos
#### Navegação (2 cenários)
- Carregamento da página inicial
- Links de navegação funcionais

#### Fluxos de Usuário (4 cenários)
- Fluxo completo de login
- Navegação filme → sessão → reserva
- Processo básico de checkout
- Logout e redirecionamento

### Testes de Integração (End-to-End) - 3 Cenários
- Fluxo completo: Login → Reserva → Checkout
- Sincronização básica de dados
- Validação de sessão de usuário

## COBERTURA DE TESTES - ESCOPO REDUZIDO

### Cobertura por Funcionalidade (10 Dias)
| Módulo | User Stories | Cenários Implementados | Cobertura |
|--------|--------------|----------------------|-----------|
| Autenticação | 4 | 4 | 70% |
| Filmes | 3 | 4 | 60% |
| Sessões | 1 | 3 | 65% |
| Reservas | 3 | 5 | 75% |
| Navegação/UX | 1 | 1 | 40% |
| **Total** | **12** | **17** | **62%** |

### Cobertura por Tipo de Teste (Realista)
- **Testes Funcionais**: 60% das funcionalidades críticas
- **Testes de API**: 70% dos endpoints essenciais
- **Testes de Interface**: 50% dos fluxos principais
- **Testes de Integração**: 40% dos cenários básicos
- **Testes de Regressão**: 30% dos cenários automatizados

### Métricas de Qualidade Ajustadas
- **Cobertura Total**: 60%+ (funcionalidades críticas)
- **Cenários Críticos**: 100%
- **Cenários de Erro**: 40%
- **Testes de Responsividade**: 20%
- **Performance**: Validação básica

## TESTES CANDIDATOS À AUTOMAÇÃO

### Prioridade 1 - Críticos (Implementação Dias 3-4)
| Cenário | Justificativa |  ROI |
|---------|---------------|----- |
| Login/Logout | Acesso básico ao sistema | Alto |
| Processo de Reserva | Funcionalidade principal | Alto |
| Validação de API | Base de todo o sistema | Alto |
| Fluxo de Checkout | Conversão crítica | Alto |

### Prioridade 2 - Importantes (Implementação Dias 5-8)
| Cenário | Justificativa | ROI |
|---------|---------------|----- |
| Catálogo de Filmes | Descoberta de conteúdo | Médio |
| Navegação Básica | UX fundamental | Médio |
| Listagem de Sessões | Consulta essencial | Médio |
| APIs de Consulta | Operações de leitura | Médio |

### Prioridade 3 - Futuras Iterações (Pós 10 dias)
| Cenário | Justificativa |  ROI |
|---------|---------------|----- |
| Registro de Usuário | Onboarding completo  | Baixo |
| Validações de Campo | UX detalhada  | Baixo |
| Responsividade | Multi-dispositivo  | Baixo |
| Performance | Otimização | Baixo |

### Critérios de Seleção para Automação
1. **ROI**: Testes executados frequentemente
2. **Criticidade**: Funcionalidades essenciais para o negócio
3. **Estabilidade**: Cenários com baixa taxa de mudança
4. **Complexidade**: Fluxos difíceis ou demorados para testar manualmente
5. **Regressão**: Cenários que precisam ser re-executados constantemente

### Ferramentas e Tecnologias
- **Framework**: Robot Framework
- **API Testing**: RequestsLibrary
- **Web Testing**: BrowserLibrary
- **Dados**: Dados estáticos com reste a cada sessão
- **Relatórios**: Robot Framework Reports
- **Versionamento**: Git 