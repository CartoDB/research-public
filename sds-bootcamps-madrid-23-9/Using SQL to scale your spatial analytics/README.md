# Using SQL to Scale your Spatial Analytics

**Link to the [talk slides](https://docs.google.com/presentation/d/1Sltt1x4uAY7K_bdFjuDnw-80HMSoLKehB1ffWtC8_b4/edit?usp=sharing)**

This repository contains all the code referenced in the talk: the complete analysis can be executed as long as the source tables from the `cartobq.docs` dataset are available. It is important to take into account that:
- All items stylized as `$name` are placeholders to be filled by the user. Usually refer to the desired project/dataset where you want a table to be created, but can also represent a personal endpoint or API key. This current setup is configured to work seamlessly using [SQLTools](https://github.com/mtxr/vscode-sqltools) from Visual Studio Code, but is also easy enough to replace the placeholders using other tools.
- There is **no need to create any of the tables**. All the tables created as `$project.$dataset.$table_name` can also be found in `cartobq.docs.$table_name`.
- In the slides, there are GitHub Octocat icons that **link each slideshow to the complete code** in this repository.
- In the slides, **all the map images are links to actual CARTO maps** where you can explore the data without the need of using SQL.
