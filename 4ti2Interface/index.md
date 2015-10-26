---
layout: package4ti2Interface
---

# GAP Package {{site.data.package4ti2Interface.name}}

{{site.data.package4ti2Interface.abstract}}

The current version of this package is version {{site.data.package4ti2Interface.version}}.
For more information, please refer to [the package manual]({{site.data.package4ti2Interface.doc-html}}).
There is also a [README](README) file.

## Dependencies

This package requires GAP version {{site.data.package4ti2Interface.GAP}}
{% if site.data.package4ti2Interface.needed-pkgs %}
The following other GAP packages are needed:
{% for pkg in site.data.package4ti2Interface.needed-pkgs %}
- {% if pkg.url %}<a href="{{ pkg.url }}">{{ pkg.name }}</a>{% else %}{{ pkg.name }}{% endif %} {{ pkg.version }}{% endfor %}
{% endif %}
{% if site.data.package4ti2Interface.suggested-pkgs %}
The following additional GAP packages are not required, but suggested:
{% for pkg in site.data.package4ti2Interface.suggested-pkgs %}
- {% if pkg.url %}<a href="{{ pkg.url }}">{{ pkg.name }}</a>{% else %}{{ pkg.name }}{% endif %} {{ pkg.version }}{% endfor %}
{% endif %}


## Author{% if site.data.package4ti2Interface.authors.size != 1 %}s{% endif %}
{% for person in site.data.package4ti2Interface.authors %}
{% if person.url %}<a href="{{ person.url }}">{{ person.name }}</a>{% else %}{{ person.name }}{% endif %}{% unless forloop.last %}, {% endunless %}{% else %}
{% endfor %}

{% if site.github.issues_url %}
## Feedback

For bug reports, feature requests and suggestions, please use the
[issue tracker]({{site.github.issues_url}}).
{% endif %}
