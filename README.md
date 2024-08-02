# GistExplorer

## Introdução

GistExplorer é um aplicativo iOS que lista os gists públicos da API do GitHub. O usuário pode visualizar detalhes ao selecionar um gist específico.

## Uso

1. Ao iniciar o aplicativo, uma lista de gists públicos será carregada.
2. Toque em um gist da lista para visualizar seus detalhes.
3. Utilize as funcionalidades de pesquisa e filtragem para encontrar gists específicos.

## Arquitetura do Projeto

O GistExplorer segue a arquitetura MVVM (Model-View-ViewModel), que promove uma separação clara das responsabilidades e facilita a manutenção e teste do código. Aqui está uma visão geral dos componentes principais:

- **Model**: Representa os dados e a lógica de negócios. No projeto, os modelos são definidos nas classes que lidam com a API e a estrutura de dados.

- **View**: Representa a interface do usuário e é responsável por apresentar os dados ao usuário. No projeto, as Views são implementadas usando View Code.

- **ViewModel**: Atua como um intermediário entre o Model e a View, transformando os dados para que a View possa exibi-los. No projeto, os ViewModels são responsáveis por gerenciar a lógica de apresentação dos dados.
