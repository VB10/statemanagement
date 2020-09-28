import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statemanagement/bloc/cats_cubit.dart';
import 'package:statemanagement/bloc/cats_repository.dart';
import 'package:statemanagement/bloc/cats_state.dart';

class BlocCatsView extends StatefulWidget {
  @override
  _BlocCatsViewState createState() => _BlocCatsViewState();
}

class _BlocCatsViewState extends State<BlocCatsView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatsCubit(SampleCatsRepository()),
      child: buildScaffold(context),
    );
  }

  Scaffold buildScaffold(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Hello"),
        ),
        body: BlocConsumer<CatsCubit, CatsState>(
          listener: (context, state) {
            if (state is CatsError) {
              Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is CatsInitial) {
              return buildCenterInitialChild(context);
            } else if (state is CatsLoading) {
              return buildCenterLoading();
            } else if (state is CatsCompleted) {
              return buildListViewCats(state);
            } else {
              return buildError(state);
            }
          },
        ),
      );

  Text buildError(CatsState state) {
    final error = state as CatsError;
    return Text(error.message);
  }

  ListView buildListViewCats(CatsCompleted state) {
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: Image.network(state.response[index].imageUrl),
        subtitle: Text(state.response[index].description),
      ),
      itemCount: state.response.length,
    );
  }

  Center buildCenterLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Center buildCenterInitialChild(BuildContext context) {
    return Center(
      child: Column(
        children: [Text("Hello"), buildFloatingActionButtonCall(context)],
      ),
    );
  }

  FloatingActionButton buildFloatingActionButtonCall(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.clear_all),
      onPressed: () {
        context.bloc<CatsCubit>().getCats();
      },
    );
  }
}
