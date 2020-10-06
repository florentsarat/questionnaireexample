@Field Project project
@Field boolean includeDiagrams // true if graphviz is installed
@Field ResourceBundle messages

section 1, "Questionnaire Example Project"
write "${project.author ?: messages.getString('generatedWithBonita') }${project.email ? " <$project.email>": ''}"
newLine()
write "v$project.version, {docdate}"
newLine()
//Generate a table of content
attr 'toc', 'left'
attr 'toc-title', messages.getString('tableOfContents')
//Depth of the table of content (max depth is 5)
attr 'toclevels', 2
//A custom attribute to store the current bonita version
attr 'bonita-version', project.bonitaVersion
attr 'imagesdir', "./$project.imageFolderPath"
//Add support for font-awesome icons (see https://fontawesome.com/v4.7.0/icons/)
attr 'icons', 'font'
attr 'sectnums', 'numbered'
attr 'sectanchors'
//Line breaks in the models will be honored in the documentation
attr 'hardbreaks'
//Add support to Menu macro
attr 'experimental'

newLine()


write 'include::documentation/static/intro.adoc[]'


newLine()

newLine()

if (project.businessDataModel) {
    layout 'bdm/bdm_template.tpl', businessDataModel:project.businessDataModel, messages:messages, includeDiagrams:includeDiagrams
}


if (project.diagrams) {
	section 2, messages.getString('diagrams')
	newLine()
	project.diagrams.each { Diagram diagram ->
		layout 'process/diagram_template.tpl', diagram:diagram, messages:messages
	}
 }
 

if (project.diagrams) {
	section 2, messages.getString('processes')
	newLine()
	project.diagrams.processes.flatten().each { Process process ->
		layout 'process/process_template.tpl', process:process, messages:messages
	}
 }


if(project.applicationDescriptors) {
    section 2, messages.getString('applications')
    newLine()
    project.applicationDescriptors.each { ApplicationDescriptor application ->
        layout 'application/application_descriptor_template.tpl', application:application, messages:messages
    }
}

if (project.applicationPages) {
	section 2, messages.getString('applicationPages')
	newLine()
	project.applicationPages.each { Page page ->
		layout 'page/pageApplication_template.tpl', page:page, messages:messages, level:3
	}
}



//if (project.organization) {
//    layout 'organization/organization_template.tpl', organization:project.organization, messages:messages, includeDiagrams:includeDiagrams
//}
