// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   group('Advice Bloc', () {
//     group('Should emits', () {
//       blocTest<AdviceBloc, AdviceState>('nothing when no event is added',
//           build: () => AdviceBloc(), expect: () => const <AdviceState>[]);

//       blocTest(
//         '[AdviceStateLoading, AdviceStateError] when AdviceRequestEvent is added',
//         build: () => AdviceBloc(),
//         act: (bloc) => bloc.add(AdviceRequestEvent()),
//         wait: const Duration(seconds: 3),
//         expect: () => const <AdviceState>[AdviceStateLoading(), AdviceStateError("Error message from bloc")],
//       );
//     });
//   });
// }
