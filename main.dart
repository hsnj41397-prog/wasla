import 'package:flutter/material.dart';

void main() => runApp(const WaslaApp());

const teal = Color(0xFF00A99D);
const ink = Color(0xFF102A43);

class WaslaApp extends StatelessWidget {
  const WaslaApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'وصلة WASLA',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: teal),
      scaffoldBackgroundColor: const Color(0xFFF5F8FA),
      fontFamily: 'Roboto',
      useMaterial3: true,
    ),
    home: const RoleScreen(),
  );
}

class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Spacer(),
        Container(
          height: 110, width: 110,
          decoration: const BoxDecoration(color: teal, shape: BoxShape.circle),
          child: const Icon(Icons.alt_route_rounded, size: 64, color: Colors.white),
        ),
        const SizedBox(height: 18),
        const Text('وصلة', textAlign: TextAlign.center,
          style: TextStyle(fontSize: 42, fontWeight: FontWeight.w900, color: ink)),
        const Text('WASLA', textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, letterSpacing: 4, fontWeight: FontWeight.bold, color: teal)),
        const SizedBox(height: 12),
        const Text('مشوارك على مزاجك', textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: ink)),
        const Spacer(),
        const Text('اختار هتستخدم وصلة إزاي', textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _roleButton(context, 'اطلب مشوار', 'راكب', Icons.person_pin_circle_rounded, true),
        const SizedBox(height: 12),
        _roleButton(context, 'اشتغل مع وصلة', 'كابتن', Icons.motorcycle_rounded, false),
        const Spacer(),
        const Text('نسخة تجريبية — الأسعار بالجنيه المصري',
          textAlign: TextAlign.center, style: TextStyle(color: Colors.black54)),
      ]),
    )),
  );

  Widget _roleButton(BuildContext context, String title, String subtitle, IconData icon, bool rider) =>
    FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: rider ? teal : Colors.white,
        foregroundColor: rider ? Colors.white : ink,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18),
          side: rider ? BorderSide.none : const BorderSide(color: Color(0xFFD9E2EC))),
      ),
      onPressed: () => Navigator.push(context, MaterialPageRoute(
        builder: (_) => rider ? const RideScreen() : const CaptainScreen())),
      child: Row(children: [
        Icon(icon, size: 32), const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(subtitle, style: const TextStyle(fontSize: 13)),
        ])),
        const Icon(Icons.chevron_left_rounded),
      ]),
    );
}

class RideScreen extends StatefulWidget {
  const RideScreen({super.key});
  @override
  State<RideScreen> createState() => _RideScreenState();
}
class _RideScreenState extends State<RideScreen> {
  bool bike = true;
  int km = 4;
  int increase = 0;
  int get base => bike ? (km * 5 < 20 ? 20 : km * 5) : (km * 10 < 40 ? 40 : km * 10);
  int get total => base + increase;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('طلب مشوار'), centerTitle: true),
    body: ListView(padding: const EdgeInsets.all(16), children: [
      Container(height: 210, decoration: BoxDecoration(
        color: const Color(0xFFE1EEF2), borderRadius: BorderRadius.circular(20)),
        child: Stack(children: const [
          Center(child: Icon(Icons.map_rounded, size: 100, color: Color(0xFF9BB9C4))),
          Positioned(top: 18, right: 18, child: Chip(label: Text('الخريطة التجريبية'))),
          Positioned(bottom: 22, left: 22, child: Icon(Icons.location_on, color: Colors.red, size: 36)),
          Positioned(top: 50, right: 70, child: Icon(Icons.my_location, color: teal, size: 34)),
        ])),
      const SizedBox(height: 16),
      _locationTile(Icons.my_location, 'مكان الركوب', 'موقعي الحالي'),
      const SizedBox(height: 8),
      _locationTile(Icons.location_on, 'الوجهة', 'حدد وجهتك'),
      const SizedBox(height: 16),
      const Text('نوع المركبة', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
      const SizedBox(height: 8),
      Row(children: [
        Expanded(child: _vehicleCard('موتوسيكل', Icons.motorcycle, bike, () => setState(()=>bike=true))),
        const SizedBox(width: 10),
        Expanded(child: _vehicleCard('سيارة', Icons.directions_car, !bike, () => setState(()=>bike=false))),
      ]),
      const SizedBox(height: 16),
      Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('المسافة التجريبية'),
          Row(children: [
            IconButton(onPressed: ()=>setState(()=>km=(km-1).clamp(1,100)), icon: const Icon(Icons.remove_circle_outline)),
            Text('$km كم', style: const TextStyle(fontWeight: FontWeight.bold)),
            IconButton(onPressed: ()=>setState(()=>km=(km+1).clamp(1,100)), icon: const Icon(Icons.add_circle_outline)),
          ]),
        ]),
        const Divider(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('السعر العادل', style: TextStyle(fontSize: 16)),
          Text('$base جنيه', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: teal)),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          const Expanded(child: Text('زيادة السعر (اختياري)')),
          IconButton.filledTonal(onPressed: ()=>setState(()=>increase=(increase-5).clamp(0,1000)), icon: const Icon(Icons.remove)),
          Text('+$increase', style: const TextStyle(fontWeight: FontWeight.bold)),
          IconButton.filled(onPressed: ()=>setState(()=>increase+=5), icon: const Icon(Icons.add)),
        ]),
        Text('التسعير: ${bike ? '5' : '10'} جنيه/كم — الحد الأدنى ${bike ? '20' : '40'} جنيه',
          style: const TextStyle(color: Colors.black54)),
      ]))),
      const SizedBox(height: 12),
      FilledButton.icon(
        style: FilledButton.styleFrom(backgroundColor: teal, padding: const EdgeInsets.all(16)),
        onPressed: ()=>showDialog(context: context, builder: (_) => AlertDialog(
          title: const Text('تم تجهيز طلبك'),
          content: Text('السعر المعروض: $total جنيه\\nهذه نسخة تجريبية بدون إرسال طلب حقيقي.'),
          actions: [TextButton(onPressed: ()=>Navigator.pop(context), child: const Text('تمام'))],
        )),
        icon: const Icon(Icons.send_rounded), label: Text('اطلب الرحلة — $total جنيه'),
      ),
    ]),
  );

  Widget _locationTile(IconData icon, String title, String value) => Card(
    child: ListTile(leading: Icon(icon, color: teal), title: Text(title),
      subtitle: Text(value), trailing: const Icon(Icons.chevron_left)));
  Widget _vehicleCard(String title, IconData icon, bool selected, VoidCallback onTap) =>
    InkWell(onTap: onTap, borderRadius: BorderRadius.circular(16), child: Container(
      padding: const EdgeInsets.all(16), decoration: BoxDecoration(
        color: selected ? const Color(0xFFE0F7F4) : Colors.white,
        border: Border.all(color: selected ? teal : const Color(0xFFD9E2EC), width: selected ? 2 : 1),
        borderRadius: BorderRadius.circular(16)),
      child: Column(children: [Icon(icon, size: 32, color: selected ? teal : ink),
        const SizedBox(height: 6), Text(title, style: const TextStyle(fontWeight: FontWeight.bold))])));
}

class CaptainScreen extends StatelessWidget {
  const CaptainScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('واجهة الكابتن'), centerTitle: true),
    body: ListView(padding: const EdgeInsets.all(16), children: [
      Container(height: 170, decoration: BoxDecoration(color: const Color(0xFFE1EEF2),
        borderRadius: BorderRadius.circular(20)), child: const Center(
        child: Icon(Icons.map_rounded, size: 90, color: Color(0xFF9BB9C4)))),
      const SizedBox(height: 16),
      const Text('طلبات قريبة منك', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('مشوار تجريبي', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('25 جنيه', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: teal)),
          ]),
          const SizedBox(height: 8),
          const Text('من: موقع الراكب\\nإلى: الوجهة المحددة\\nالمسافة: 4 كم'),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: FilledButton(onPressed: ()=>_msg(context,'تم قبول الطلب التجريبي'),
              child: const Text('قبول الرحلة'))),
            const SizedBox(width: 8),
            Expanded(child: OutlinedButton(onPressed: ()=>_msg(context,'تم تجاهل الطلب'),
              child: const Text('تجاهل'))),
          ]),
        ]))),
      const Card(child: ListTile(leading: Icon(Icons.account_balance_wallet, color: teal),
        title: Text('أرباح اليوم'), subtitle: Text('0 جنيه — نموذج تجريبي'))),
    ]),
  );
  void _msg(BuildContext context, String s) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));
}
