<cfoutput>
	<div class="container">
		<h1>#viewbag.title#</h1>
		<h2>#helper.tr('general.today', LSDateFormat(now(), "dddd", activeLang))#</h2>
		<p>#viewbag.description#</p>

		<p>
			<a href="#rc.linkTo('demo', 'example')#">#helper.tr('demo.example.linkLabel')#</a>
		</p>

		<p>
			<a href="#rc.linkTo('demo', 'anySpecificName')#">#helper.tr('demo.anySpecificName.linkLabel')#</a>
		</p>

		<p>
			<a href="#rc.linkTo('demo', 'pagingExample')#">#helper.tr('demo.pagingExample.linkLabel')#</a>
		</p>

		<div class="container" style="border: 1px solid grey;">
			<p>#helper.tr('default.home.queriesExampleInstruction')#</p>
<pre><i>
CREATE TABLE [dbo].[examples](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[f1] [datetime] NULL,
	[f2] [int] NULL,
	[f3] [bit] NULL,
	[f4] [varchar](100) NULL,
 CONSTRAINT [PK_examples] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
</i></pre>
			<p>
				<a href="#rc.linkTo('demo', 'queriesExample')#">#helper.tr('demo.queriesExample.linkLabel')#</a>
			</p>
		</div>
	</div>
	
</cfoutput>
