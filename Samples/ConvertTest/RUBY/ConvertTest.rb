#---------------------------------------------------------------------------------------
# Copyright (c) 2001-2018 by PDFTron Systems Inc. All Rights Reserved.
# Consult LICENSE.txt regarding license information.
#---------------------------------------------------------------------------------------

require '../../../PDFNetC/Lib/PDFNetRuby'
include PDFNetRuby

$stdout.sync = true

#---------------------------------------------------------------------------------------
# The following sample illustrates how to use the PDF.Convert utility class to convert 
# documents and files to PDF, XPS, SVG, or EMF.
#
# Certain file formats such as XPS, EMF, PDF, and raster image formats can be directly 
# converted to PDF or XPS. Other formats are converted using a virtual driver. To check 
# if ToPDF (or ToXPS) require that PDFNet printer is installed use Convert.RequiresPrinter(filename). 
# The installing application must be run as administrator. The manifest for this sample 
# specifies appropriate the UAC elevation.
#
# Note: the PDFNet printer is a virtual XPS printer supported on Vista SP1 and Windows 7.
# For Windows XP SP2 or higher, or Vista SP0 you need to install the XPS Essentials Pack (or 
# equivalent redistributables). You can download the XPS Essentials Pack from:
#        http:#www.microsoft.com/downloads/details.aspx?FamilyId=B8DCFFDD-E3A5-44CC-8021-7649FD37FFEE&displaylang=en
# Windows XP Sp2 will also need the Microsoft Core XML Services (MSXML) 6.0:
#         http:#www.microsoft.com/downloads/details.aspx?familyid=993C0BCF-3BCF-4009-BE21-27E85E1857B1&displaylang=en
#
# Note: Convert.fromEmf and Convert.toEmf will only work on Windows and require GDI+.
#
# Please contact us if you have any questions.    
#---------------------------------------------------------------------------------------

# Relative path to the folder containing the test files.
$inputPath = "../../TestFiles/"
$outputPath = "../../TestFiles/Output/"

# convert from a file to PDF automatically
def ConvertToPdfFromFile()
    testfiles = [
       ["butterfly.png", "png2pdf.pdf"],
       ["simple-xps.xps", "xps2pdf.pdf"]
    ]
    
    for testfile in testfiles
		pdfdoc = PDFDoc.new()
		inputFile = $inputPath + testfile[0]
		outputFile = $outputPath + testfile[1]
		Convert.ToPdf(pdfdoc, inputFile)
		pdfdoc.Save(outputFile, SDFDoc::E_compatibility)
		pdfdoc.Close()
		puts "Converted file: " + inputFile + "\n\tto: " + outputFile
    end
end

def ConvertSpecificFormats()
	# Start with a PDFDoc to collect the converted documents
	pdfdoc = PDFDoc.new()
	s1 = $inputPath + "simple-xps.xps"
	
	puts "Converting from XPS " + s1
	Convert.FromXps(pdfdoc, s1)
	outputFile = $outputPath + "pdf_from_xps.pdf"
	pdfdoc.Save(outputFile, SDFDoc::E_remove_unused)
	puts "Saved " + outputFile
	
	# Convert the two page PDF document to SVG
	puts "Converting pdfdoc to SVG"
	outputFile = $outputPath + "pdfdoc2svg.svg"
	Convert.ToSvg(pdfdoc, outputFile)
	puts "Saved " + outputFile
	
	# Convert the PDF document to XPS
	puts "Converting pdfdoc to XPS"
	outputFile = $outputPath + "pdfdoc2xps.xps"
	Convert.ToXps(pdfdoc, outputFile)
	puts "Saved " + outputFile
	
	# Convert the PNG image to XPS
	puts "Converting PNG to XPS"
	outputFile = $outputPath + "png2xps.xps"
	Convert.ToXps($inputPath + "butterfly.png", outputFile)
	puts "Saved " + outputFile
	
	# Convert PDF document to XPS
	puts "Converting PDF to XPS"
	outputFile = $outputPath + "pdf2xps.xps"
	Convert.ToXps($inputPath + "newsletter.pdf", outputFile)
	puts "Saved " + outputFile

	# Convert PDF document to HTML
	puts "Converting PDF to HTML"
	outputFile = $outputPath + "pdf2html"
	Convert.ToHtml($inputPath + "newsletter.pdf", outputFile)
	puts "Saved " + outputFile

	# Convert PDF document to EPUB
	puts "Converting PDF to EPUB"
	outputFile = $outputPath + "pdf2epub.epub"
	Convert.ToEpub($inputPath + "newsletter.pdf", outputFile)
	puts "Saved " + outputFile
end
	
def main()
	# The first step in every application using PDFNet is to initialize the 
	# library. The library is usually initialized only once, but calling 
	# Initialize() multiple times is also fine.
	PDFNet.Initialize()
	
	# Demonstrate Convert.ToPdf and Convert.Printer
	ConvertToPdfFromFile()
	
	# Demonstrate Convert.[FromEmf, FromXps, ToEmf, ToSVG, ToXPS]
	ConvertSpecificFormats()

	puts "Done."
end

main()
