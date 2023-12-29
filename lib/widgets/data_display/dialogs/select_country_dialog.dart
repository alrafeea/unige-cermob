import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../text.dart';

// ignore: must_be_immutable
class SelectCountryDialog extends StatefulWidget {
  final Function(dynamic) onValueSelected;
  dynamic selectedCountry;

  SelectCountryDialog(
      {Key key, /*this.relationTypes,*/ this.onValueSelected, this.selectedCountry});

  @override
  _SelectCountryDialogState createState() => _SelectCountryDialogState();
}

class _SelectCountryDialogState extends State<SelectCountryDialog> {

  // todo create a model for Country
  List<Map> countryList =
    [
      {
        "name": "Saudi Arabia",
        "name_ar":"المملكة العربية السعودية",
        "code": "+966",
        "countryCode": "SA",
        "pattern": "5xxxxxxxx",
        "maxLength": 9
      },
      {
        "name": "United Arab Emirates",
        "name_ar":"الإمارات العربية المتحدة",
        "code": "+971",
        "countryCode": "AE",
        "pattern": "5xxxxxxxx",
        "maxLength": 9
      },
      {
        "name": "Bahrain",
        "name_ar":"البحرين",
        "code": "+973",
        "countryCode": "BH",
        "maxLength": 8
      },
      {
        "name": "Kuwait",
        "name_ar":"الكويت",
        "code": "+965",
        "countryCode": "KW"
      },
      {
        "name": "Afghanistan",
        "name_ar":"أفغانستان",
        "code": "+93",
        "countryCode": "AF"
      },
      {
        "name": "Aland Islands",
        "name_ar":"جزر آلاند",
        "code": "+358",
        "countryCode": "AX"
      },
      {
        "name": "Albania",
        "name_ar":"ألبانيا",
        "code": "+355",
        "countryCode": "AL"
      },
      {
        "name": "Algeria",
        "name_ar":"الجزائر",
        "code": "+213",
        "countryCode": "DZ"
      },
      {
        "name": "AmericanSamoa",
        "name_ar":"ساموا الأمريكية",
        "code": "+1 684",
        "countryCode": "AS"
      },
      {
        "name": "Andorra",
        "name_ar":"أندورا",
        "code": "+376",
        "countryCode": "AD"
      },
      {
        "name": "Angola",
        "name_ar":"أنغولا",
        "code": "+244",
        "countryCode": "AO"
      },
      {
        "name": "Anguilla",
        "name_ar":"أنغيلا",
        "code": "+1 264",
        "countryCode": "AI"
      },
      {
        "name": "Antarctica",
        "name_ar":"القارة القطبية الجنوبية",
        "code": "+672",
        "countryCode": "AQ"
      },
      {
        "name": "Antigua and Barbuda",
        "name_ar":"أنتيغوا وبربودا",
        "code": "+1268",
        "countryCode": "AG"
      },
      {
        "name": "Argentina",
        "name_ar":"الأرجنتين",
        "code": "+54",
        "countryCode": "AR"
      },
      {
        "name": "Armenia",
        "name_ar":"أرمينيا",
        "code": "+374",
        "countryCode": "AM"
      },
      {
        "name": "Aruba",
        "name_ar":"أروبا",
        "code": "+297",
        "countryCode": "AW"
      },
      {
        "name": "Australia",
        "name_ar":"أستراليا",
        "code": "+61",
        "countryCode": "AU"
      },
      {
        "name": "Austria",
        "name_ar":"النمسا",
        "code": "+43",
        "countryCode": "AT"
      },
      {
        "name": "Azerbaijan",
        "name_ar":"أذربيجان",
        "code": "+994",
        "countryCode": "AZ"
      },
      {
        "name": "Bahamas",
        "name_ar":"الباهاما",
        "code": "+1 242",
        "countryCode": "BS"
      },
      {
        "name": "Bangladesh",
        "name_ar":"بنغلاديش",
        "code": "+880",
        "countryCode": "BD"
      },
      {
        "name": "Barbados",
        "name_ar":"بربادوس",
        "code": "+1 246",
        "countryCode": "BB"
      },
      {
        "name": "Belarus",
        "name_ar":"روسيا البيضاء",
        "code": "+375",
        "countryCode": "BY"
      },
      {
        "name": "Belgium",
        "name_ar":"بلجيكا",
        "code": "+32",
        "countryCode": "BE"
      },
      {
        "name": "Belize",
        "name_ar":"بليز",
        "code": "+501",
        "countryCode": "BZ"
      },
      {
        "name": "Benin",
        "name_ar":"بنين",
        "code": "+229",
        "countryCode": "BJ"
      },
      {
        "name": "Bermuda",
        "name_ar":"برمودا",
        "code": "+1 441",
        "countryCode": "BM"
      },
      {
        "name": "Bhutan",
        "name_ar":"بوتان",
        "code": "+975",
        "countryCode": "BT"
      },
      {
        "name": "Bolivia, Plurinational State of",
        "name_ar":"دولة بوليفيا المتعددة القوميات",
        "code": "+591",
        "countryCode": "BO"
      },
      {
        "name": "Bosnia and Herzegovina",
        "name_ar":"البوسنة والهرسك",
        "code": "+387",
        "countryCode": "BA"
      },
      {
        "name": "Botswana",
        "name_ar":"بوتسوانا",
        "code": "+267",
        "countryCode": "BW"
      },
      {
        "name": "Brazil",
        "name_ar":"البرازيل",
        "code": "+55",
        "countryCode": "BR"
      },
      {
        "name": "British Indian Ocean Territory",
        "name_ar":"إقليم المحيط البريطاني الهندي",
        "code": "+246",
        "countryCode": "IO"
      },
      {
        "name": "Brunei Darussalam",
        "name_ar":"بروناي دار السلام",
        "code": "+673",
        "countryCode": "BN"
      },
      {
        "name": "Bulgaria",
        "name_ar":"بلغاريا",
        "code": "+359",
        "countryCode": "BG"
      },
      {
        "name": "Burkina Faso",
        "name_ar":"بوركينا فاسو",
        "code": "+226",
        "countryCode": "BF"
      },
      {
        "name": "Burundi",
        "name_ar":"بوروندي",
        "code": "+257",
        "countryCode": "BI"
      },
      {
        "name": "Cambodia",
        "name_ar":"كمبوديا",
        "code": "+855",
        "countryCode": "KH"
      },
      {
        "name": "Cameroon",
        "name_ar":"الكاميرون",
        "code": "+237",
        "countryCode": "CM"
      },
      {
        "name": "Canada",
        "name_ar":"كندا",
        "code": "+1",
        "countryCode": "CA"
      },
      {
        "name": "Cape Verde",
        "name_ar":"الرأس الأخضر",
        "code": "+238",
        "countryCode": "CV"
      },
      {
        "name": "Cayman Islands",
        "name_ar":"جزر كايمان",
        "code": "+345",
        "countryCode": "KY"
      },
      {
        "name": "Central African Republic",
        "name_ar":"جمهورية افريقيا الوسطى",
        "code": "+236",
        "countryCode": "CF"
      },
      {
        "name": "Chad",
        "name_ar":"تشاد",
        "code": "+235",
        "countryCode": "TD"
      },
      {
        "name": "Chile",
        "name_ar":"تشيلي",
        "code": "+56",
        "countryCode": "CL"
      },
      {
        "name": "China",
        "name_ar":"الصين",
        "code": "+86",
        "countryCode": "CN"
      },
      {
        "name": "Christmas Island",
        "name_ar":"جزيرة الكريسماس",
        "code": "+61",
        "countryCode": "CX"
      },
      {
        "name": "Cocos (Keeling) Islands",
        "name_ar":"جزر كوكوس كيلينغ",
        "code": "+61",
        "countryCode": "CC"
      },
      {
        "name": "Colombia",
        "name_ar":"كولومبيا",
        "code": "+57",
        "countryCode": "CO"
      },
      {
        "name": "Comoros",
        "name_ar":"جزر القمر",
        "code": "+269",
        "countryCode": "KM"
      },
      {
        "name": "Congo",
        "name_ar":"الكونغو",
        "code": "+242",
        "countryCode": "CG"
      },
      {
        "name": "Congo, The Democratic Republic of the Congo",
        "name_ar":"الكونغو ، جمهورية الكونغو الديمقراطية",
        "code": "+243",
        "countryCode": "CD"
      },
      {
        "name": "Cook Islands",
        "name_ar":"جزر كوك",
        "code": "+682",
        "countryCode": "CK"
      },
      {
        "name": "Costa Rica",
        "name_ar":"كوستا ريكا",
        "code": "+506",
        "countryCode": "CR"
      },
      {
        "name": "Cote d'Ivoire",
        "name_ar":"ساحل العاج",
        "code": "+225",
        "countryCode": "CI"
      },
      {
        "name": "Croatia",
        "name_ar":"كرواتيا",
        "code": "+385",
        "countryCode": "HR"
      },
      {
        "name": "Cuba",
        "name_ar":"كوبا",
        "code": "+53",
        "countryCode": "CU"
      },
      {
        "name": "Cyprus",
        "name_ar":"قبرص",
        "code": "+357",
        "countryCode": "CY"
      },
      {
        "name": "Czech Republic",
        "name_ar":"جمهورية التشيك",
        "code": "+420",
        "countryCode": "CZ"
      },
      {
        "name": "Denmark",
        "name_ar":"الدنمارك",
        "code": "+45",
        "countryCode": "DK"
      },
      {
        "name": "Djibouti",
        "name_ar":"جيبوتي",
        "code": "+253",
        "countryCode": "DJ"
      },
      {
        "name": "Dominica",
        "name_ar":"دومينيكا",
        "code": "+1 767",
        "countryCode": "DM"
      },
      {
        "name": "Dominican Republic",
        "name_ar":"جمهورية الدومنيكان",
        "code": "+1 849",
        "countryCode": "DO"
      },
      {
        "name": "Ecuador",
        "name_ar":"الإكوادور",
        "code": "+593",
        "countryCode": "EC"
      },
      {
        "name": "Egypt",
        "name_ar":"مصر",
        "code": "+20",
        "countryCode": "EG"
      },
      {
        "name": "El Salvador",
        "name_ar":"السلفادور",
        "code": "+503",
        "countryCode": "SV"
      },
      {
        "name": "Equatorial Guinea",
        "name_ar":"غينيا الإستوائية",
        "code": "+240",
        "countryCode": "GQ"
      },
      {
        "name": "Eritrea",
        "name_ar":"إريتريا",
        "code": "+291",
        "countryCode": "ER"
      },
      {
        "name": "Estonia",
        "name_ar":"استونيا",
        "code": "+372",
        "countryCode": "EE"
      },
      {
        "name": "Ethiopia",
        "name_ar":"أثيوبيا",
        "code": "+251",
        "countryCode": "ET"
      },
      {
        "name": "Falkland Islands (Malvinas)",
        "name_ar":"جزر فوكلاند مالفيناس",
        "code": "+500",
        "countryCode": "FK"
      },
      {
        "name": "Faroe Islands",
        "name_ar":"جزر صناعية",
        "code": "+298",
        "countryCode": "FO"
      },
      {
        "name": "Fiji",
        "name_ar":"فيجي",
        "code": "+679",
        "countryCode": "FJ"
      },
      {
        "name": "Finland",
        "name_ar":"فنلندا",
        "code": "+358",
        "countryCode": "FI"
      },
      {
        "name": "France",
        "name_ar":"فرنسا",
        "code": "+33",
        "countryCode": "FR"
      },
      {
        "name": "French Guiana",
        "name_ar":"غيانا الفرنسية",
        "code": "+594",
        "countryCode": "GF"
      },
      {
        "name": "French Polynesia",
        "name_ar":"بولينيزيا الفرنسية",
        "code": "+689",
        "countryCode": "PF"
      },
      {
        "name": "Gabon",
        "name_ar":"الغابون",
        "code": "+241",
        "countryCode": "GA"
      },
      {
        "name": "Gambia",
        "name_ar":"غامبيا",
        "code": "+220",
        "countryCode": "GM"
      },
      {
        "name": "Georgia",
        "name_ar":"جورجيا",
        "code": "+995",
        "countryCode": "GE"
      },
      {
        "name": "Germany",
        "name_ar":"ألمانيا",
        "code": "+49",
        "countryCode": "DE"
      },
      {
        "name": "Ghana",
        "name_ar":"غانا",
        "code": "+233",
        "countryCode": "GH"
      },
      {
        "name": "Gibraltar",
        "name_ar":"جبل طارق",
        "code": "+350",
        "countryCode": "GI"
      },
      {
        "name": "Greece",
        "name_ar":"اليونان",
        "code": "+30",
        "countryCode": "GR"
      },
      {
        "name": "Greenland",
        "name_ar":"الأرض الخضراء",
        "code": "+299",
        "countryCode": "GL"
      },
      {
        "name": "Grenada",
        "name_ar":"غرينادا",
        "code": "+1 473",
        "countryCode": "GD"
      },
      {
        "name": "Guadeloupe",
        "name_ar":"جوادلوب",
        "code": "+590",
        "countryCode": "GP"
      },
      {
        "name": "Guam",
        "name_ar":"غوام",
        "code": "+1 671",
        "countryCode": "GU"
      },
      {
        "name": "Guatemala",
        "name_ar":"غواتيمالا",
        "code": "+502",
        "countryCode": "GT"
      },
      {
        "name": "Guernsey",
        "name_ar":"غيرنسي",
        "code": "+44",
        "countryCode": "GG"
      },
      {
        "name": "Guinea",
        "name_ar":"غينيا",
        "code": "+224",
        "countryCode": "GN"
      },
      {
        "name": "Guinea-Bissau",
        "name_ar":"غينيا بيساو",
        "code": "+245",
        "countryCode": "GW"
      },
      {
        "name": "Guyana",
        "name_ar":"غيانا",
        "code": "+595",
        "countryCode": "GY"
      },
      {
        "name": "Haiti",
        "name_ar":"هايتي",
        "code": "+509",
        "countryCode": "HT"
      },
      {
        "name": "Holy See (Vatican City State)",
        "name_ar":"الكرسي الرسولي دولة الفاتيكان",
        "code": "+379",
        "countryCode": "VA"
      },
      {
        "name": "Honduras",
        "name_ar":"هندوراس",
        "code": "+504",
        "countryCode": "HN"
      },
      {
        "name": "Hong Kong",
        "name_ar":"هونج كونج",
        "code": "+852",
        "countryCode": "HK"
      },
      {
        "name": "Hungary",
        "name_ar":"اليونان",
        "code": "+36",
        "countryCode": "HU"
      },
      {
        "name": "Iceland",
        "name_ar":"أيسلندا",
        "code": "+354",
        "countryCode": "IS"
      },
      {
        "name": "India",
        "name_ar":"الهند",
        "code": "+91",
        "countryCode": "IN"
      },
      {
        "name": "Indonesia",
        "name_ar":"أندونيسيا",
        "code": "+62",
        "countryCode": "ID"
      },
      {
        "name": "Iran, Islamic Republic of Persian Gulf",
        "name_ar":"جمهورية إيران الإسلامية الخليج الفارسي",
        "code": "+98",
        "countryCode": "IR"
      },
      {
        "name": "Iraq",
        "name_ar":"العراق",
        "code": "+964",
        "countryCode": "IQ"
      },
      {
        "name": "Ireland",
        "name_ar":"أيرلندا",
        "code": "+353",
        "countryCode": "IE"
      },
      {
        "name": "Isle of Man",
        "name_ar":"جزيرة آيل أوف مان",
        "code": "+44",
        "countryCode": "IM"
      },
      {
        "name": "Italy",
        "name_ar":"إيطاليا",
        "code": "+39",
        "countryCode": "IT"
      },
      {
        "name": "Jamaica",
        "name_ar":"جامايكا",
        "code": "+1 876",
        "countryCode": "JM"
      },
      {
        "name": "Japan",
        "name_ar":"اليابان",
        "code": "+81",
        "countryCode": "JP"
      },
      {
        "name": "Jersey",
        "name_ar":"جيرسي",
        "code": "+44",
        "countryCode": "JE"
      },
      {
        "name": "Jordan",
        "name_ar":"الأردن",
        "code": "+962",
        "countryCode": "JO"
      },
      {
        "name": "Kazakhstan",
        "name_ar":"كازاخستان",
        "code": "+77",
        "countryCode": "KZ"
      },
      {
        "name": "Kenya",
        "name_ar":"كينيا",
        "code": "+254",
        "countryCode": "KE"
      },
      {
        "name": "Kiribati",
        "name_ar":"كيريباس",
        "code": "+686",
        "countryCode": "KI"
      },
      {
        "name": "Korea, Democratic People's Republic of Korea",
        "name_ar":"جمهورية كوريا الديمقراطية الشعبية",
        "code": "+850",
        "countryCode": "KP"
      },
      {
        "name": "Korea, Republic of South Korea",
        "name_ar":"جمهورية كوريا الديمقراطية الشعبية",
        "code": "+82",
        "countryCode": "KR"
      },
      {
        "name": "Kyrgyzstan",
        "name_ar":"قرغيزستان",
        "code": "+996",
        "countryCode": "KG"
      },
      {
        "name": "Laos",
        "name_ar":"لاوس",
        "code": "+856",
        "countryCode": "LA"
      },
      {
        "name": "Latvia",
        "name_ar":"لاتفيا",
        "code": "+371",
        "countryCode": "LV"
      },
      {
        "name": "Lebanon",
        "name_ar":"لبنان",
        "code": "+961",
        "countryCode": "LB"
      },
      {
        "name": "Lesotho",
        "name_ar":"ليسوتو",
        "code": "+266",
        "countryCode": "LS"
      },
      {
        "name": "Liberia",
        "name_ar":"ليبيريا",
        "code": "+231",
        "countryCode": "LR"
      },
      {
        "name": "Libyan Arab Jamahiriya",
        "name_ar":"الجماهيرية العربية الليبية",
        "code": "+218",
        "countryCode": "LY"
      },
      {
        "name": "Liechtenstein",
        "name_ar":"ليختنشتاين",
        "code": "+423",
        "countryCode": "LI"
      },
      {
        "name": "Lithuania",
        "name_ar":"ليتوانيا",
        "code": "+370",
        "countryCode": "LT"
      },
      {
        "name": "Luxembourg",
        "name_ar":"لوكسمبورغ",
        "code": "+352",
        "countryCode": "LU"
      },
      {
        "name": "Macao",
        "name_ar":"ماكاو",
        "code": "+853",
        "countryCode": "MO"
      },
      {
        "name": "Macedonia",
        "name_ar":"مقدونيا",
        "code": "+389",
        "countryCode": "MK"
      },
      {
        "name": "Madagascar",
        "name_ar":"مدغشقر",
        "code": "+261",
        "countryCode": "MG"
      },
      {
        "name": "Malawi",
        "name_ar":"مالاوي",
        "code": "+265",
        "countryCode": "MW"
      },
      {
        "name": "Malaysia",
        "name_ar":"ماليزيا",
        "code": "+60",
        "countryCode": "MY"
      },
      {
        "name": "Maldives",
        "name_ar":"جزر المالديف",
        "code": "+960",
        "countryCode": "MV"
      },
      {
        "name": "Mali",
        "name_ar":"مالي",
        "code": "+223",
        "countryCode": "ML"
      },
      {
        "name": "Malta",
        "name_ar":"مالطا",
        "code": "+356",
        "countryCode": "MT"
      },
      {
        "name": "Marshall Islands",
        "name_ar":"جزر مارشال",
        "code": "+692",
        "countryCode": "MH"
      },
      {
        "name": "Martinique",
        "name_ar":"مارتينيك",
        "code": "+596",
        "countryCode": "MQ"
      },
      {
        "name": "Mauritania",
        "name_ar":"موريتانيا",
        "code": "+222",
        "countryCode": "MR"
      },
      {
        "name": "Mauritius",
        "name_ar":"موريشيوس",
        "code": "+230",
        "countryCode": "MU"
      },
      {
        "name": "Mayotte",
        "name_ar":"مايوت",
        "code": "+262",
        "countryCode": "YT"
      },
      {
        "name": "Mexico",
        "name_ar":"المكسيك",
        "code": "+52",
        "countryCode": "MX"
      },
      {
        "name": "Micronesia, Federated States of Micronesia",
        "name_ar":"ميكرونيزيا ، ولايات ميكرونيزيا الموحدة",
        "code": "+691",
        "countryCode": "FM"
      },
      {
        "name": "Moldova",
        "name_ar":"مولدوفا",
        "code": "+373",
        "countryCode": "MD"
      },
      {
        "name": "Monaco",
        "name_ar":"موناكو",
        "code": "+377",
        "countryCode": "MC"
      },
      {
        "name": "Mongolia",
        "name_ar":"منغوليا",
        "code": "+976",
        "countryCode": "MN"
      },
      {
        "name": "Montenegro",
        "name_ar":"الجبل الأسود",
        "code": "+382",
        "countryCode": "ME"
      },
      {
        "name": "Montserrat",
        "name_ar":"مونتسيرات",
        "code": "+1664",
        "countryCode": "MS"
      },
      {
        "name": "Morocco",
        "name_ar":"المغرب",
        "code": "+212",
        "countryCode": "MA"
      },
      {
        "name": "Mozambique",
        "name_ar":"موزمبيق",
        "code": "+258",
        "countryCode": "MZ"
      },
      {
        "name": "Myanmar",
        "name_ar":"ميانمار",
        "code": "+95",
        "countryCode": "MM"
      },
      {
        "name": "Namibia",
        "name_ar":"ناميبيا",
        "code": "+264",
        "countryCode": "NA"
      },
      {
        "name": "Nauru",
        "name_ar":"ناورو",
        "code": "+674",
        "countryCode": "NR"
      },
      {
        "name": "Nepal",
        "name_ar":"نيبال",
        "code": "+977",
        "countryCode": "NP"
      },
      {
        "name": "Netherlands",
        "name_ar":"هولندا",
        "code": "+31",
        "countryCode": "NL"
      },
      {
        "name": "Netherlands Antilles",
        "name_ar":"جزر الأنتيل الهولندية",
        "code": "+599",
        "countryCode": "AN"
      },
      {
        "name": "New Caledonia",
        "name_ar":"كاليدونيا الجديدة",
        "code": "+687",
        "countryCode": "NC"
      },
      {
        "name": "New Zealand",
        "name_ar":"نيوزيلندا",
        "code": "+64",
        "countryCode": "NZ"
      },
      {
        "name": "Nicaragua",
        "name_ar":"نيكاراغوا",
        "code": "+505",
        "countryCode": "NI"
      },
      {
        "name": "Niger",
        "name_ar":"النيجر",
        "code": "+227",
        "countryCode": "NE"
      },
      {
        "name": "Nigeria",
        "name_ar":"نيجيريا",
        "code": "+234",
        "countryCode": "NG"
      },
      {
        "name": "Niue",
        "name_ar":"نيوي",
        "code": "+683",
        "countryCode": "NU"
      },
      {
        "name": "Norfolk Island",
        "name_ar":"جزيرة نورفولك",
        "code": "+672",
        "countryCode": "NF"
      },
      {
        "name": "Northern Mariana Islands",
        "name_ar":"جزر مريانا الشمالية",
        "code": "+1 670",
        "countryCode": "MP"
      },
      {
        "name": "Norway",
        "name_ar":"النرويج",
        "code": "+47",
        "countryCode": "NO"
      },
      {
        "name": "Oman",
        "name_ar":"سلطنة عمان",
        "code": "+968",
        "countryCode": "OM"
      },
      {
        "name": "Pakistan",
        "name_ar":"باكستان",
        "code": "+92",
        "countryCode": "PK"
      },
      {
        "name": "Palau",
        "name_ar":"بالاو",
        "code": "+680",
        "countryCode": "PW"
      },
      {
        "name": "Palestinian Territory, Occupied",
        "name_ar":"الأراضي الفلسطينية المحتلة",
        "code": "+970",
        "countryCode": "PS"
      },
      {
        "name": "Panama",
        "name_ar":"بناما",
        "code": "+507",
        "countryCode": "PA"
      },
      {
        "name": "Papua New Guinea",
        "name_ar":"بابوا غينيا الجديدة",
        "code": "+675",
        "countryCode": "PG"
      },
      {
        "name": "Paraguay",
        "name_ar":"باراغواي",
        "code": "+595",
        "countryCode": "PY"
      },
      {
        "name": "Peru",
        "name_ar":"بيرو",
        "code": "+51",
        "countryCode": "PE"
      },
      {
        "name": "Philippines",
        "name_ar":"الفلبين",
        "code": "+63",
        "countryCode": "PH"
      },
      {
        "name": "Pitcairn",
        "name_ar":"بيتكيرن",
        "code": "+872",
        "countryCode": "PN"
      },
      {
        "name": "Poland",
        "name_ar":"بولندا",
        "code": "+48",
        "countryCode": "PL"
      },
      {
        "name": "Portugal",
        "name_ar":"البرتغال",
        "code": "+351",
        "countryCode": "PT"
      },
      {
        "name": "Puerto Rico",
        "name_ar":"بورتوريكو",
        "code": "+1 939",
        "countryCode": "PR"
      },
      {
        "name": "Qatar",
        "name_ar":"دولة قطر",
        "code": "+974",
        "countryCode": "QA"
      },
      {
        "name": "Romania",
        "name_ar":"رومانيا",
        "code": "+40",
        "countryCode": "RO"
      },
      {
        "name": "Russia",
        "name_ar":"روسيا",
        "code": "+7",
        "countryCode": "RU"
      },
      {
        "name": "Rwanda",
        "name_ar":"رواندا",
        "code": "+250",
        "countryCode": "RW"
      },
      {
        "name": "Reunion",
        "name_ar":"جمع شمل",
        "code": "+262",
        "countryCode": "RE"
      },
      {
        "name": "Saint Barthelemy",
        "name_ar":"سانت بارتيليمي",
        "code": "+590",
        "countryCode": "BL"
      },
      {
        "name": "Saint Helena, Ascension and Tristan Da Cunha",
        "name_ar":"سانت هيلانة ، أسنشن وتريستان دا كونها",
        "code": "+290",
        "countryCode": "SH"
      },
      {
        "name": "Saint Kitts and Nevis",
        "name_ar":"سانت كيتس ونيفيس",
        "code": "+1 869",
        "countryCode": "KN"
      },
      {
        "name": "Saint Lucia",
        "name_ar":"القديسة لوسيا",
        "code": "+1 758",
        "countryCode": "LC"
      },
      {
        "name": "Saint Martin",
        "name_ar":"القديس مارتن",
        "code": "+590",
        "countryCode": "MF"
      },
      {
        "name": "Saint Pierre and Miquelon",
        "name_ar":"سانت بيير وميكلون",
        "code": "+508",
        "countryCode": "PM"
      },
      {
        "name": "Saint Vincent and the Grenadines",
        "name_ar":"سانت فنسنت وجزر غرينادين",
        "code": "+1 784",
        "countryCode": "VC"
      },
      {
        "name": "Samoa",
        "name_ar":"ساموا",
        "code": "+685",
        "countryCode": "WS"
      },
      {
        "name": "San Marino",
        "name_ar":"سان مارينو",
        "code": "+378",
        "countryCode": "SM"
      },
      {
        "name": "Sao Tome and Principe",
        "name_ar":"ساو تومي وبرينسيبي",
        "code": "+239",
        "countryCode": "ST"
      },
      {
        "name": "Senegal",
        "name_ar":"السنغال",
        "code": "+221",
        "countryCode": "SN"
      },
      {
        "name": "Serbia",
        "name_ar":"صربيا",
        "code": "+381",
        "countryCode": "RS"
      },
      {
        "name": "Seychelles",
        "name_ar":"سيشيل",
        "code": "+248",
        "countryCode": "SC"
      },
      {
        "name": "Sierra Leone",
        "name_ar":"سيرا ليون",
        "code": "+232",
        "countryCode": "SL"
      },
      {
        "name": "Singapore",
        "name_ar":"سنغافورة",
        "code": "+65",
        "countryCode": "SG"
      },
      {
        "name": "Slovakia",
        "name_ar":"سلوفاكيا",
        "code": "+421",
        "countryCode": "SK"
      },
      {
        "name": "Slovenia",
        "name_ar":"سلوفينيا",
        "code": "+386",
        "countryCode": "SI"
      },
      {
        "name": "Solomon Islands",
        "name_ar":"جزر سليمان",
        "code": "+677",
        "countryCode": "SB"
      },
      {
        "name": "Somalia",
        "name_ar":"الصومال",
        "code": "+252",
        "countryCode": "SO"
      },
      {
        "name": "South Africa",
        "name_ar":"جنوب أفريقيا",
        "code": "+27",
        "countryCode": "ZA"
      },
      {
        "name": "South Georgia and the South Sandwich Islands",
        "name_ar":"جورجيا الجنوبية وجزر ساندويتش الجنوبية",
        "code": "+500",
        "countryCode": "GS"
      },
      {
        "name": "Spain",
        "name_ar":"إسبانيا",
        "code": "+34",
        "countryCode": "ES"
      },
      {
        "name": "Sri Lanka",
        "name_ar":"سيريلانكا",
        "code": "+94",
        "countryCode": "LK"
      },
      {
        "name": "Sudan",
        "name_ar":"سودان",
        "code": "+249",
        "countryCode": "SD"
      },
      {
        "name": "Suriname",
        "name_ar":"سورينام",
        "code": "+597",
        "countryCode": "SR"
      },
      {
        "name": "Svalbard and Jan Mayen",
        "name_ar":"سفالبارد وجان ماين",
        "code": "+47",
        "countryCode": "SJ"
      },
      {
        "name": "Swaziland",
        "name_ar":"سوازيلاند",
        "code": "+268",
        "countryCode": "SZ"
      },
      {
        "name": "Sweden",
        "name_ar":"السويد",
        "code": "+46",
        "countryCode": "SE"
      },
      {
        "name": "Switzerland",
        "name_ar":"سويسرا",
        "code": "+41",
        "countryCode": "CH"
      },
      {
        "name": "Syrian Arab Republic",
        "name_ar":"الجمهورية العربية السورية",
        "code": "+963",
        "countryCode": "SY"
      },
      {
        "name": "Taiwan",
        "name_ar":"تايوان",
        "code": "+886",
        "countryCode": "TW"
      },
      {
        "name": "Tajikistan",
        "name_ar":"طاجيكستان",
        "code": "+992",
        "countryCode": "TJ"
      },
      {
        "name": "Tanzania, United Republic of Tanzania",
        "name_ar":"تنزانيا ، جمهورية تنزانيا المتحدة",
        "code": "+255",
        "countryCode": "TZ"
      },
      {
        "name": "Thailand",
        "name_ar":"تايلاند",
        "code": "+66",
        "countryCode": "TH"
      },
      {
        "name": "Timor-Leste",
        "name_ar":"تيمور الشرقية",
        "code": "+670",
        "countryCode": "TL"
      },
      {
        "name": "Togo",
        "name_ar":"ليذهب",
        "code": "+228",
        "countryCode": "TG"
      },
      {
        "name": "Tokelau",
        "name_ar":"توكيلاو",
        "code": "+690",
        "countryCode": "TK"
      },
      {
        "name": "Tonga",
        "name_ar":"تونغا",
        "code": "+676",
        "countryCode": "TO"
      },
      {
        "name": "Trinidad and Tobago",
        "name_ar":"ترينداد وتوباغو",
        "code": "+1 868",
        "countryCode": "TT"
      },
      {
        "name": "Tunisia",
        "name_ar":"تونس",
        "code": "+216",
        "countryCode": "TN"
      },
      {
        "name": "Turkey",
        "name_ar":"ديك رومي",
        "code": "+90",
        "countryCode": "TR"
      },
      {
        "name": "Turkmenistan",
        "name_ar":"تركمانستان",
        "code": "+993",
        "countryCode": "TM"
      },
      {
        "name": "Turks and Caicos Islands",
        "name_ar":"جزر تركس وكايكوس",
        "code": "+1 649",
        "countryCode": "TC"
      },
      {
        "name": "Tuvalu",
        "name_ar":"توفالو",
        "code": "+688",
        "countryCode": "TV"
      },
      {
        "name": "Uganda",
        "name_ar":"أوغندا",
        "code": "+256",
        "countryCode": "UG"
      },
      {
        "name": "Ukraine",
        "name_ar":"أوكرانيا",
        "code": "+380",
        "countryCode": "UA"
      },
      {
        "name": "United Kingdom",
        "name_ar":"المملكة المتحدة",
        "code": "+44",
        "countryCode": "GB"
      },
      {
        "name": "United States",
        "name_ar":"الولايات المتحدة الامريكانية",
        "code": "+1",
        "countryCode": "US"
      },
      {
        "name": "Uruguay",
        "name_ar":"أوروغواي",
        "code": "+598",
        "countryCode": "UY"
      },
      {
        "name": "Uzbekistan",
        "name_ar":"أوزبكستان",
        "code": "+998",
        "countryCode": "UZ"
      },
      {
        "name": "Vanuatu",
        "name_ar":"فانواتو",
        "code": "+678",
        "countryCode": "VU"
      },
      {
        "name": "Venezuela, Bolivarian Republic of Venezuela",
        "name_ar":"فنزويلا ، جمهورية فنزويلا البوليفارية",
        "code": "+58",
        "countryCode": "VE"
      },
      {
        "name": "Vietnam",
        "name_ar":"فيتنام",
        "code": "+84",
        "countryCode": "VN"
      },
      {
        "name": "Virgin Islands, British",
        "name_ar":"جزر العذراء البريطانية",
        "code": "+1 284",
        "countryCode": "VG"
      },
      {
        "name": "Virgin Islands, U.S.",
        "name_ar":"جزر فيرجن ، الولايات المتحدة",
        "code": "+1 340",
        "countryCode": "VI"
      },
      {
        "name": "Wallis and Futuna",
        "name_ar":"واليس وفوتونا",
        "code": "+681",
        "countryCode": "WF"
      },
      {
        "name": "Yemen",
        "name_ar":"اليمن",
        "code": "+967",
        "countryCode": "YE"
      },
      {
        "name": "Zambia",
        "name_ar":"زامبيا",
        "code": "+260",
        "countryCode": "ZM"
      },
      {
        "name": "Zimbabwe",
        "name_ar":"زيمبابوي",
        "code": "+263",
        "countryCode": "ZW"
      }
    ];

  @override
  void initState() {
    super.initState();
    widget.selectedCountry = widget.selectedCountry ?? countryList[0];
  }

  @override
  Widget build(BuildContext context) {
      return SimpleDialog(
      children: [
        Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.60,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(
                      countryList.length,
                          (index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      widget.selectedCountry = countryList[index];
                                    });
                                  },
                                  child: ListTile(
                                    title: Text(countryList[index]["name"]),
                                    leading: Radio(
                                      value: countryList[index],
                                      groupValue: widget.selectedCountry,
                                      activeColor: Colors.red[800],
                                      onChanged: (value) {
                                        setState(() {
                                          widget.selectedCountry = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ),

            SizedBox(
              height: 5.0,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Center(
                          child: Texts(
                            "Cancel",
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 30,
                  color: Colors.grey[500],
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      widget.onValueSelected(widget.selectedCountry);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Texts(
                            "OK",
                      )),
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
