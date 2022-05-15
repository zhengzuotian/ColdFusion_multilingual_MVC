<cfscript>
	///////////////
	// Local env //
	///////////////
	///*
	appconfig = {
		dsn: 'demo_dev',
		env: 'dev',
		supportLangs: ['en', 'fr', 'es'],
		stripe: {
			secretKey: 'sk_test_xxxxxxxxxxxxxxxxxxxxxxxx',
			publicKey: 'pk_test_xxxxxxxxxxxxxxxxxxxxxxxx'
		},
		root: "",
		rootPub: "",
		rootPubAssets: "/assets",
		path: "C:\ColdFusion2018\cfusion\wwwroot\demo",
		emailAttributes: {
			from: "info@example.com",
			server: "email-smtp.example.com",
			useTLS: "yes",
			port: "25",
			username = "username",
			password = "password"
		}
	}
	//*/



	//////////////////////
	// Live env example //
	/////////////////////
	/*
	appconfig = {
		dsn: 'dbname_prod',
		env: 'prod',
		supportLangs: ['en', 'fr', 'es'],
		stripe: {
			secretKey: 'sk_live_xxxxxxxxxxxxxxxxxxxxxxxxx',
			publicKey: 'pk_live_xxxxxxxxxxxxxxxxxxxxxxxxx'
		},
		root: "https://www.example.com",
		rootPub: "https://www.example.com",
		rootPubAssets: "https://www.examplee.com/assets",
		path: "C:\sites\demo",
		emailAttributes: {
			from: "info@example.com",
			server: "email-smtp.example.com",
			useTLS: "yes",
			port: "25",
			username = "username",
			password = "password"
		}
	}
	*/
</cfscript>