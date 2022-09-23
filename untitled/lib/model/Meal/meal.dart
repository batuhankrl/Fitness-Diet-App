class Meal {
  final String mealTime, name, imagePath, kiloCaloriesBurnt, timeTaken;
  final String preparation;
  final List ingredients;

  Meal({required this.mealTime, required this.name, required this.imagePath, required this.kiloCaloriesBurnt, required this.timeTaken, required this.preparation, required this.ingredients});
}

final meals = [

  Meal(
      mealTime: "KAHVALTI",
      name: "Yulaf Tost",
      kiloCaloriesBurnt: "271",
      timeTaken: "10",
      imagePath: "assets/yulaf-tost.jpg",
      ingredients: [
        "4 yemek kaşığı yulaf ezmesi",
        "1 yemek kaşığı yoğurt",
        "1 adet yumurta",
        "30 gram kaşar veya çeçil peyniri",
        "Tuz",
      ],
      preparation:
      '''Merhaba. Yulaf ezmesi, yoğurt ve yumurtayı tuzunu da ekleyip, güzelce karıştıralım.
Yağlı kağıt serili ısıtılmış tost makinesine dökelim.
Bir miktar piştikten sonra içine peynirimizi ekleyelim ve katlayalım.
Yulaf ekmeğimiz kızardıktan ve peynirimiz de eridikten sonra tostumuz hazır..'''),
  Meal(
      mealTime: "ÖĞLE/AKŞAM YEMEĞİ",
      name: "Mercimek Mantısı",
      kiloCaloriesBurnt: "271",
      timeTaken: "35",
      imagePath: "assets/mercimek-mantisi.jpg",
      ingredients: [
        "1 bardak kırmızı mercimek",
        "2 su bardağı su",
        "Tuz, kırmızı biber, karabiber, kimyon",
        "2-3 dal maydanoz",
        "2-3 dal dereotu ",
        "1-2 diş sarımsak",
        "Yoğurt",
        "Yağ",
        "Kırmızı biber",
      ],
      preparation:
      '''1 bardak kırmızı mercimek önce yıkanır, tencereye alınır.
Üzerine 2 bardak su eklenir sonra mercimek suyunu çekinceye kadar pişirilir.
Pişen mercimeğin üzerine baharatlar eklenir ve yoğrulur.
Misket büyüklüğünde toplar yapılır tabaklara dizilir.
Daha sonra üzeri için sarımsaklı yoğurt ve kırmızı biberli sos yapılıp, üzerine dökülür.'''),

  Meal(
      mealTime: "ÖĞLE/AKŞAM YEMEĞİ",
      name: "Kabak Spagetti",
      kiloCaloriesBurnt: "612",
      timeTaken: "30",
      imagePath: "assets/kabak-spagetti.jpg",
      ingredients: [
        "4 adet orta boy kabak",
        "4 yemek kaşığı zeytinyağı",
        "Tuz",
        "1 adet büyük boy domates",
        "1 yemek kaşığı domates salçası",
        "3 yemek kaşığı sıcak su",
        "2 diş sarımsak",
        "2 yemek kaşığı zeytinyağı",
        "Karabiber",
        "Pul biber",
      ],
      preparation:
      '''Kabaklarımızı soyduktan sonra, salatalık-patates soyacağı ile uzun uzun şeritler çıkarıyoruz. Fotoğraftan net anlaşılıyor veya bıçak yardımı ile ince ince şeritler çıkarabilirsiniz.
Tavada yüksek ateşte kabaklar hafif kızarmaya başlayana kadar pişiriyoruz. Tuzunu da ekleyip altını kısmadan sürekli kavuracağız. Hafif bir su salıp çekiyor.
Kabağımızı kavururken bir yandan da domates sosumuzu hazırlıyoruz.
Sosu için uygun bir tencereye zeytinyağını ve sarımsakları ince ince doğrayıp tencereye ekleyerek bir iki tur kavuruyoruz.
Rendelenmiş domatesleri, karabiberi, pul biberi, yağı ve salçayı tavada kavuruyoruz. Kaynamaya başlayınca içine su ve tuz ilave ediyoruz. Pişiriyoruz.
Kavurduğumuz kabakları da ekleyip bir kaç dakika daha pişirelim. Üzerine de isteğe bağlı dilediğimiz miktarda kaşar rendesi koyuyoruz.'''),

  Meal(
      mealTime: "ATIŞTIRMALIK",
      name: "Kabak Mücver",
      kiloCaloriesBurnt: "414",
      timeTaken: "50",
      imagePath: "assets/kabak-mucver.jpg",
      ingredients: [
        "4 adet orta boy kabak",
        "2 adet yumurta",
        "Yarım demet dereotu",
        "20-25 adet maydanoz",
        "8-10 adet yeşil soğan",
        "200 gram beyaz peynir",
        "1 çay bardağı un",
        "1 adet kabartma tozu",
        "Yarım kahve fincanı sıvı yağ",
        "Tuz, karabiber, pul biber",
        "Diyette olmayanlar için üzerine serpmek için 250 gr kaşar peyniri",
      ],
      preparation:
      '''Kabakları soyun, rendeleyin ve suyunu sıkarak çıkarın.
Diğer yeşillikleri ince ince doğrayın.
Beyaz peyniri bir çatal yardımıyla ezin.
Yumurtaları ayrı bir kapta iyice çırpın, köpük köpük olsun.
Bütün malzemeleri krep yapıyormuş gibi birleştirin.
Burada önemli olan unun miktarını ayarlamanız. Çok cıvık olmasın ki içini çekerek pişsin.
Fırın kabınızı çok az yağla yağlayın yada pişirme kağıdı kullanabilirsiniz.
Tüm malzemeyi kabınıza boşaltın ve önceden 200 derecede ısıtılmış fırınınıza sürün. Süre ve ısı veremeyeceğim, ben turbo fırınımda pişirdim biraz çabuk pişiriyor. Sonra ısıyı düşürüp içini çekmesini sağlıyorum mesela.
Kızarmaya başlayınca çıkarıp kaşar peyniri serpin ve kaşarlar eriyip kızarıncaya kadar pişirin.
Dileyen sarımsaklı yoğurtla servis edebilir ve dereotu ile süsleyebilir. Afiyet olsun.'''),

  Meal(
      mealTime: "ÖĞLE/AKŞAM YEMEĞİ",
      name: "Tavuk Tabağı",
      kiloCaloriesBurnt: "612",
      timeTaken: "25",
      imagePath: "assets/tavuk-tabagi.jpg",
      ingredients: [
        "150 gr ince kesilmiş veya küp doğranmış tavuk göğsü",
        "Kekik",
        "Pulbiber",
        "Karabiber",
        "Kimyon",
        "2 diş ezilmiş sarımsak"
            "1 tutam maydanoz",
        "3 -4 dal marul",
        "2 adet yeşil biber",

      ],
      preparation:
      '''Tavuk göğsüne baharatlar eklenir ve yağlı kağıt serilmiş tepsiye dizilir ,önceden ısıtılmış fırında kızarana kadar pişirilir.
Dilerseniz biberleri de tavukların yanına koyup pişirebilirsiniz.'''),


];