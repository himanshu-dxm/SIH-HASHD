import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'pdf_format.dart';

void generatePDF(Title title,Id id,Details details,ImagesUpload images){
  var pdf = new Document();
  //first page
  pdf.addPage(
    MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin:EdgeInsets.all(10),
      maxPages: 1,
      build: (context){
      return[
        Report.buildTitle(title),
        Container(width: 100),
        Report.buildID(title, id),
        Container(height: 100),
        Report.buildDetails(details),
      ];
    })
  );

  for(int i=0;i<images.images.length;i++)
  {
    pdf.addPage(
      MultiPage(
        margin: EdgeInsets.all(10),
        pageFormat: PdfPageFormat.a4,
        maxPages: 1,
        build: (c){
          return [
            Wrap(
              children: [
                Container(
                  decoration: pw.BoxDecoration(
                    image: pw.DecorationImage(image: images.images[i],fit: BoxFit.fill)
                  )
                ),
              ]
            )
          ];
        }
      ),
    );
  }
  


}