// Copyright information

function copyright(relativePath) {
    let date = new Date();
    let startingYear = 2011;
    let currentYear = date.getFullYear();

    document.write("<div class=\"copyright\">\n");
    document.write("    <div class=\"left\">\n");
    document.write("        Copyright "+startingYear+((currentYear == startingYear)?"":"-"+currentYear)+"\n");
    document.write("    </div>\n");
    document.write("    <div class=\"center\">\n");
    document.write("        <a class=\"copyright\" href=\"https://twitter.com/TeamOpenCOR/\"><img class=\"twitter\" src=\""+relativePath+"/twitter.png\" width=30 height=30></a>\n");
    document.write("    </div>\n");
    document.write("    <div class=\"right\">\n");
    document.write("        <a class=\"copyright\" href=\"https://virtualrat.org/\"><img class=\"vpr\" src=\""+relativePath+"/vpr.png\" width=60 height=18></a>\n");
    document.write("    </div>\n");
    document.write("</div>\n");
}
