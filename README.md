# retorfit_net_bound_resource

How to implement Network Bounding Resource.

## Purpose
The main purpose in this project is implement some core subjects describe above:
* Clean Architecture
* Dependency injection
* Network Bounding Resource

## Clean Architecture
This concept is defined by Uncle Boob and further reading is necessary. To this project we will
focus in these articles:
1. [Clean Architecture for Enterprise Flutter Application](https://geekysingh.medium.com/clean-architecture-for-enterprise-flutter-application-dc254a71059)

About article Clean Architecture for Enterprise Flutter Application, we focus on split our code
on four packages named core, domain, data and presentation.
@startuml
package "Business" {
[domain]
[data]
}

package "Presentation" {
[Login]
[Others features]
}

package "Core" {
[Navigation service]
[Dialog service]
[Toast service]
}

Presentation --> Core
Presentation --> domain
domain --> data
@enduml

1. core: Here you can find all the common implementation, like dialogs, toasts, navigation. All the
   common utilities classes should be defined here. It's an independent module.
2. domain: Here stay all business rules. It's independent of the development platform and it's
   written purely in Dart. It's independent of Flutter also.
   This module defines only abstraction of business rules and it's implementation lay on data 
   module.
3. data: Defines the implementation of domain module. Common implementation is database interaction 
   and network calls. This module depends on domain module.
4. presentation: This module defines all feature. This module initializes data and domain module.

Redrawing our architecture to Flutter will be like this:

@startuml
'https://plantuml.com/component-diagram

node "Presentation" {
[Widgets] -> [ViewModel]
[Widgets] <- [ViewModel]
}

node "Domain" {
[UseCases]
[Entities]
}

node "Data" {
[Repositories] --> [DAO]
[Repositories] --> [Services]
[Services] --> cloud
[DAO] --> database
}

[ViewModel] --> [UseCases]
[ViewModel] <-- [UseCases]
[UseCases] --> [Repositories]
[Repositories] --> [Entities]

@enduml

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
