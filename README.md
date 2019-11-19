# testmovies

### Features
#### 1. Generales
##### 1. Capas de la aplicación
- Networking : Capa encargada de realizar las peticiones a la API de MovieDB, configurar el tipo de petición (POST o GET), parámetros, timeout, detección de internet, etc
- Models: Capa encargada de modelar los datos que se utilizan en la app. Los datos provienen de la nube y otros generados por el usuario
- Controllers: Capa encargada para la lógica del negocio, interacción del usuario y configuración de las vistas
- Preferences: Capa encargada para hacer cache local de los JSON consultados por el usuario
- Util: Capa encargada para el manejo de constantes globales de la app
- Extensions: Capa encargada de extender la funcionalidad de componentes específicos como Strings, ViewControllers, UIColor, etc
- Views: Capa encargada para vistas personalizadas como SnackBars, Alertas, Loaders, etc
- Assets: Manejo de recursos (imagenes, iconos, plist, etc) del proyecto

##### 1. Responsabilidad de las clases creadas
- NetworkManager: Clase que realiza las peticiones a la API de MovieDB
- CacheManager: Clase encargada para hacer cache de la información de las peliculas para cargarla cuando no hay internet
- Constants: Constantes globales del proyecto, fonts, urls, etc
- Extensions (UIColor, UIViewController): Extensiones para aumentar la funcionalidad de ciertos componentes
- BaseVC: Controlador Base del cual heredan todos los controladores del proyecto, en este controlador se codifican cosas genéricas
- MoviesVC: Controllador que se encarga de mostrar las peliculas en UITableView que se descargan con NetworkManager
- MovieDetailVC: Controllador para mostrar el detalle de la pelicula
- Views (Snackbar, Loader): Vistas personalidas para mostrar alertas y una vista con animación mientras cargan los datos. Estas vistas son reusables en otros proyectos
- Models (User, Movie): Clases para modelar al usuario de la app y modelar el JSON de cada pelicula en un objeto para que sea más manejable en el proyecto

#### 2. Preguntas

#####1. El princio de responsabilidad única
- Sucede cuando un módulo del software (ejemplo una clase) esta destinado a tener una funcionalidad específica bien definida en el proyecto, debe estar encapsulada, modular (para que sea más legible y escalable).

#####2. Un buen código limpio es aquel código que:
- Emplea patrones de desarrollo establecidos desde el origen. MVC, MVVM, etc
- Maneja un estilo de programación que maneja todo el equipo de desarrollo (ejemplo https://github.com/raywenderlich/objective-c-style-guide)
- Hace uno de nombres para variables, constantes, funciones, etc adecuados
- Sigue las reglas de negocio para el proyecto
- Es modular, autocontenido, reusable y robusto
- Está documentado a cierto nivel para conocer la funcionalidad de variables, funciones, enums, etc
- No contiene muchos espacios, código comentado, código legacy, etc
- Debe ser auditado empleado herramientas como CLOC (Count Lines Of Code http://cloc.sourceforge.net) para poder evaluar el código (número de líneas, comentarios, espacios, número de archivos, etc)





