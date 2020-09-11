<h1 align="center">
  <br/>
  <img src="https://raw.githubusercontent.com/hrool20/iOSMovieApp/master/iOSMovieApp/Main/Assets.xcassets/app_logo.imageset/app_logo.png" alt="Markdownify" width="200">
  <br/>
  Movie App
  <br/>
</h1>

`Movie App` es una app donde podrás ver información de películas. Para este proyecto se utilizaron dos patrones:
- `MVC (Model View Controller)`: Puede ser encontrado en la branch [***master***](https://github.com/hrool20/iOSMovieApp/tree/master) de este proyecto.
- `MVP (Model View Presenter)`: Puede ser encontrado en la branch [***Model_View_Presenter***](https://github.com/hrool20/iOSMovieApp/tree/Model_View_Presenter) de este proyecto.
<br/>

Además, la app soporta dos idiomas: **español** e **ingles**. Para poder cambiar de idioma en la app, se debe cambiar el idioma del dispositivo móvil. En este proyecto se utilizaron las siguientes bibliotecas (libraries) externas:
- [**Alamofire**](https://github.com/Alamofire/Alamofire) - Utilizado para el consumo de servicios (API's).
- [**IQKeyboardManager**](https://github.com/hackiftekhar/IQKeyboardManager) - Utilizado para facilitar la gestión del Keyboard.
- [**SDWebImage**](https://github.com/SDWebImage/SDWebImage) - Utilizado para la conversión de urls a imágenes.
- [**SkeletonView**](https://github.com/Juanpe/SkeletonView) - Utilizado para mostrar un ***efecto Shimmer*** al momento de cargar las películas disponibles.
- [**SVProgressHUD**](https://github.com/SVProgressHUD/SVProgressHUD) - Utilizado para mostrar un `Activity indicator` en cualquier parte del proyecto.
- [**SwiftyJSON**](https://github.com/SwiftyJSON/SwiftyJSON) - Utilizado para la conversión de diccionarios a `JSON Objects` o `JSON Arrays`.


## Instalación

Para poder instalar las bibliotecas (libraries) externas, debes utilizar el siguiente comando:
```
pod install
```
