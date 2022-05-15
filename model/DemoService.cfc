component {
	property name="gateway" type="component";
	property name="helper" type="component";

	public component function init( required string datasource, required string lang, required component helper){
		this.gateway = createObject("component", "DemoGateway").init(arguments.datasource, arguments.lang);
		this.helper = arguments.helper;
		return this;
	}


	public array function getPays() {
		var q = this.gateway.getPays();
		return this.helper.convertQuery2Array(q);
	}


	public numeric function getExamplePageTotal() {
		return 999;
	}


	public array function getExampleData(page, numberPerPage, total) {
		var data = [];

		if ((page-1) * numberPerPage > total) {
			return data;
		}

		for (var i = 1; i <= numberPerPage; i++) {
			var sequence =  i + numberPerPage * (page - 1);
			if (sequence > total) {
				break;
			}
			arrayAppend(data, {
				'itemNum': sequence,
				'description': randomText(randRange(3, 7))
			});
		}

		return data;
	}


	private string function randomText(num) {
		var soup = "Lorem ipsum dolor sit amet Et veniam harum non delectus odit Quis eligendi aut atque ducimus Hic accusantium inventore At optio voluptatem hic modi labore est natus corporis! Ad alias enim et dolores rerum vel assumenda dolores accusamus totam id doloribus enim Aut dolor quasi ut nostrum accusamus qui optio consequatur rem ipsa libero id odit officiis Non accusamus repellendus ut inventore dolores aut veritatis fugit quo nemo officia eum natus corporis Et dolorem voluptatem est illum laborum eos explicabo impedit in ullam corrupti Qui internos quae qui repudiandae accusamus qui cumque soluta qui nisi ipsum et quam doloribus sed beatae doloribus. Cum dolorem dolor facilis modi ea repellendus asperiores eos voluptates maiores ut vitae sunt";
		var arr = listToArray(soup, " ");
		var total = ArrayLen(arr);

		var choice = [];
		for (var i = 0; i < num; i++) {
			arrayAppend(choice, arr[randRange(1, total)]);
		}

		return uCase(arrayToList(choice, " "));
	}


	public numeric function getDataTotal() {
		var q = this.gateway.getDataTotal();
		return q.num;
	}


	public array function getData(page, numberPerPage) {
		var q = this.gateway.getData(page, numberPerPage);
		return this.helper.convertQuery2Array(q);
	}
}