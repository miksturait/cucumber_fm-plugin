"define metadata";
({
    "description" : "Gherkin syntax highlighter",
    "dependencies" : { "standard_syntax" : "0.0.0" },
    "environments": { "worker": true },
    "provides":
    [
        {
            "ep": "syntax",
            "name": "gherkin",
            "pointer": "#GherkinSyntax",
            "fileexts": ["feature"]
        },
        {
            "ep": "themestyles",
            "url": [
                "gherkin.less"
            ]
        }

    ]
});
"end";

//var StandardSyntax = require('standard_syntax').StandardSyntax;

var states = {}

states['topic_keywords'] = [
    {
        regex: /(Feature:|Scenario:|Scenario Outline:)/,
        tag: 'topic_keyword'
    },
    {
        regex:  /^\s*#.*$/,
        tag:    'comment'
    },
]

exports.GherkinSyntax = new StandardSyntax.create(states, ['js']);
