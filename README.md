## About The Project

Very simple MVC template built for ColdFusion to get started quickly for bilingual or multilingual websites. The philosophy is to keep the coding as simple as possible so that we can dive into coding business logic right away instead of studying a long list of framework documentation. In this MVC, a page is an action in a controller to keep it straightforth and never get lost in finding all the pieces of code everywhere.


## ColdFusion version

The demo site is coding with ColdFusion 2018. It should be also working for some previous versions as there are not fancy functions in use.


## Getting Started

Setting up your project locally.

The below instruction is based on Windows + IIS environment. If you are working on Linux, you need to find out the equivalent way to do it, for example, use Apache instead of IIS and use .htaccess to do the same thing as web.config. 

1. Clone the whole folder to your project folder
2. Enable local IIS on your windows features
3. Add the site to the IIS, binding to a local domain you select, for example, demo.local. Listen to both hhtp 80 and https 443 ports.
4. Run wsconfig.exe under your ColdFusion installation folder\cfusion\runtime\bin, for example, C:\ColdFusion2018\cfusion\runtime\bin\wsconfig.exe
5. Follow the instruction of wsconfig and complete the connector adding.
6. Open hosts file and add your site, for example, 127.0.0.1 demo.local
7. Open the browser and enter demo.local. Your website should be up.


## Deployment to production

After deploying to the production environment, important to add URL param ?cleancache to clean the caches of MVC objects. The controllers, services, gateways, config, and translation data are cached to improve the performance in production envronment.


## Folder structure

- assets
  Contain all css, js, images, and other public documents

- config
  env file. This file will contain all settings for the local or production environment. It also includes credentials, API keys, email attributes, etc. As it includes sensible data, this file shouldn't be put in the repository. Instead, you can put a local env file to the repository to share with other developers to get started. When deploying manually, do not upload this file unless necessary.

- controllers
  All controllers are located here. Generally, 1 module use 1 controller, for example, DemoController.cfc. There are also some special controllers:
  `Controller.cfc` This is the parent of other controllers. It defines all services for each controller. It initiates also default values in the viewbag.
  `RequestionController.cfc` This is the controller to take the requests and decide which controller and action should be invoked for each request. It defines the routes for each language. It also generates URL for different languages.
  `DefaultController.cfc` Define home page and 404 page. You can use a different name because it works the same way as a module controller.

- locale
  Supported languages in JSON format. Here you do the translation.

- model
  The services and gateways. The services are injected into the Controller.cfc. That means each controller has access to all services. Usually, 1 controller has 1 service and 1 gateway under the same name.
  `Gateway.cfc` The parent of all gateways.
  `dataService.cfc` and `dataGateway.cfc` are for the beans mappings. They work together to provide a quick way to read/update/delete records in the database without writing SQLs. It's optional. You can choose not to use them.

- utils
  `helper.cfc` Useful static functions. Also, the translation function tr() will be used a lot in views. The controllers have also access to the helper.

- views
  Templates and pages.

- application.cfc
  Define processor variables in Application/REQUEST scope. The MVC doesn't depend on it.

- index.cfm
  All traffic will be redirected to it by web.config

- web.config
  Redirect all traffic to index except existing files in assets. It redirects also webroot to the default language, for example, /en/ 


## Usage

### Add a new page
1. Create an action
A page is an action in a controller. Simply add an action (method). fpr example, exampleAction() into an existing module (controller), for example DemoController.cfc. Initiate the viewbag, do more stuff and add data to viewbag when necessary, and return the viewbag.
2. Add URL route for the action created in RequestController.routeSettings() for all supported languages. If the route is missing, the request will be redirected to 404 page.
3. Create an view file under views/pages/your_module/ with the action name followed by View suffix, for example, views/pages/demo/exampleView.cfm
4. User rc.linkTo('module_name', 'action_name'), for example, rc.linkTo('demo', 'example'), to generate the link to the page.
5. (Optional) Add page level js with the same name in the assets folder, for example, assets/pages/demo/scripts/example.js
6. (Optional) Add page level css with the same name in the assets folder, for example, assets/pages/demo/css/example.css

### Create a new module
1. Copy DemoController.cfc, DemoService.cfc, DemoGateway.cfc and rename them with your module name.
2. Register the service in Controller.cfc.
3. Create a folder under pages for the module and create a view page for the action.
4. (Optional) Add module level js with the same name in the assets folder, for example, assets/scripts/demo.js
5. (Optional) Add module level css with the same name in the assets folder, for example, assets/css/demo.css

### Add / remove language supported
- Update env.cfm to add or remove the array supportLangs
- Add or remove the mappings in the init() and routeSettings() of RequestController.cfc
- Add or remove json file in the locale folder

### Form handling
See the example page.

### Form handling with AJAX
See the example page.

### Pagination
See the pagination example page.

### Database
See the queries CRUD example.


## Contributing

Contributions are what make the open-source community such a fantastic place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request


## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

## Contact

Simon Zheng - zhengzt@gmail.com
