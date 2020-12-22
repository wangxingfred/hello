using System;
using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;

using System.IO.Packaging;

namespace hello_openxml
{
    static class Program
    {
        static void Main(string[] args)
        {
            var filePath = "../../0.xlsx";
            var document1 = SpreadsheetDocument.Open(filePath, false);
            Console.WriteLine($"{document1.WorkbookPart.Workbook.Sheets.InnerText}");

            filePath = "../../0.xml";
            var document2 = SpreadsheetDocument.Open(filePath, false);
            Console.WriteLine($"{document2.WorkbookPart.Workbook.Sheets.InnerText}");
        }
    }
}