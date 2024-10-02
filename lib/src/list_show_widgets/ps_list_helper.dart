part of '../../pure_scale_widgets.dart';

class PsListViewBuilderOptions {
  /// Constructor of [PsListViewBuilderOptions].
  PsListViewBuilderOptions({
    this.scrollDirection,
    this.reverse,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap,
    this.padding,
    this.itemExtent,
    this.prototypeItem,
    this.findChildIndexCallback,
    this.addAutomaticKeepAlives,
    this.addRepaintBoundaries,
    this.addSemanticIndexes,
    this.cacheExtent,
    this.semanticChildCount,
    this.dragStartBehavior,
    this.keyboardDismissBehavior,
    this.restorationId,
    this.clipBehavior,
  });

  /// See [ListView.builder.scrollDirection] for more information.
  final Axis? scrollDirection;

  /// See [ListView.builder.reverse] for more information.
  final bool? reverse;

  /// See [ListView.builder.controller] for more information.
  final ScrollController? controller;

  /// See [ListView.builder.primary] for more information.
  final bool? primary;

  /// See [ListView.builder.physics] for more information.
  final ScrollPhysics? physics;

  /// See [ListView.builder.shrinkWrap] for more information.
  final bool? shrinkWrap;

  /// See [ListView.builder.padding] for more information.
  final EdgeInsetsGeometry? padding;

  /// See [ListView.builder.itemExtent] for more information.
  final double? itemExtent;

  /// See [ListView.builder.prototypeItem] for more information.
  final Widget? prototypeItem;

  /// See [ListView.builder.findChildIndexCallback] for more information.
  final ChildIndexGetter? findChildIndexCallback;

  /// See [ListView.builder.addAutomaticKeepAlives] for more information.
  final bool? addAutomaticKeepAlives;

  /// See [ListView.builder.addRepaintBoundaries] for more information.
  final bool? addRepaintBoundaries;

  /// See [ListView.builder.addSemanticIndexes] for more information.
  final bool? addSemanticIndexes;

  /// See [ListView.builder.cacheExtent] for more information.
  final double? cacheExtent;

  /// See [ListView.builder.semanticChildCount] for more information.
  final int? semanticChildCount;

  /// See [ListView.builder.dragStartBehavior] for more information.
  final DragStartBehavior? dragStartBehavior;

  /// See [ListView.builder.keyboardDismissBehavior] for more information.
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;

  /// See [ListView.builder.restorationId] for more information.
  final String? restorationId;

  /// See [ListView.builder.clipBehavior] for more information.
  final Clip? clipBehavior;
}

class PsListScrollController<T> {
  /// when rendering it will return numbers of item in a row.
  final Function(int)? onItemCount;

  /// when rendering it will return item's width
  final Function(double)? onItemWidth;

  /// it is for getting numbers of items per page from network by default
  /// it will 10.
  final int perPage;

  /// to get the state of [PsListView]
  PsListViewState<T>? widgetState;

  /// Callback function on pull up to load more data and refresh
  final Future<List<T>?> Function(int page, int perPage, Map? params) onFuture;

  final List<T>? futureList;
  final bool? isLoading;
  final bool? noDataFound;
  final int? page;
  final bool? isLastPage;

  void _bind(PsListViewState<T> state) {
    widgetState = state;
  }

  PsListScrollController({
    this.onItemCount,
    this.onItemWidth,
    required this.onFuture,
    this.futureList,
    this.isLoading,
    this.noDataFound,
    this.page,
    this.isLastPage,
    this.perPage = 10,
  });

  /// TO refresh the network call.
  Future<List<T>?> refresh({
    Map? params,
  }) async {
    return await widgetState?.loadFutureList(params: params);
  }
}

class PsListView<T> extends StatefulWidget {
  /// Whether need pull refresh or not.
  final bool pullRefresh;

  /// Builder for getting list of widget. [listData] it will return the same getting from network.
  final Widget Function(BuildContext context, List<T> listData, int index)
      builder;

  final Widget? loadingMoreWidget;
  final Widget? loadingWidget;

  final Widget? headerWidget;
  final Widget? footerWidget;

  final Widget Function(PsListScrollController<T> controller)?
      noDataFoundWidget;
  final Widget Function(PsListScrollController<T> controller)? errorWidget;

  ///
  /// Object that can be set if any of the [ListView.builder] options
  /// need to be overridden. The [ResponsiveGridList] defines the builder
  /// and item count. All other options are optional and can be set through
  /// this object.
  ///
  final PsListViewBuilderOptions? listViewBuilderOptions;

  ///
  /// The minimum item width of each individual item in the list. Can be smaller
  /// if the viewport constraints are smaller.
  ///
  final double minItemWidth;

  ///
  ///
  /// If you wanted to keep Alive this widget with tabs.
  ///
  final bool keepAlive;

  ///
  /// Minimum items to show per row. If this is set to a value higher than 1,
  /// this takes precedence over [minItemWidth] and allows items to be smaller
  /// than [minItemWidth] to fit at least [minItemsPerRow] items.
  ///
  final int minItemsPerRow;

  ///
  /// Maximum items to show per row. By default the package shows all items that
  /// fit into the available space according to [minItemWidth].
  ///
  /// Note that this should only be used when limiting items on large screens
  /// since it will stretch [maxItemsPerRow] items across the whole width
  /// when maximum is reached. This can result in a large difference to
  /// [minItemWidth].
  ///
  final int? maxItemsPerRow;

  ///how many more list you want to show as an loader.
  final int? loaderSize;

  ///
  /// The horizontal spacing between the items in the grid.
  ///
  final double horizontalGridSpacing;

  ///
  /// The vertical spacing between the items in the grid.
  ///
  final double verticalGridSpacing;

  ///
  /// The horizontal spacing around the grid.
  ///
  final double? horizontalGridMargin;

  ///
  /// The vertical spacing around the grid.
  ///
  final double? verticalGridMargin;

  ///
  /// [MainAxisAlignment] of each row in the grid list.
  ///
  final MainAxisAlignment rowMainAxisAlignment; // coverage:ignore-end

  ///
  ///[AdvancedInfiniteScrollController] it can help to refresh the list manually,
  ///
  final PsListScrollController<T> controller;

  const PsListView({
    super.key,
    this.listViewBuilderOptions,
    required this.minItemWidth,
    required this.minItemsPerRow,
    this.maxItemsPerRow,
    this.horizontalGridSpacing = 1,
    this.verticalGridSpacing = 1,
    this.rowMainAxisAlignment = MainAxisAlignment.start,
    this.horizontalGridMargin,
    this.verticalGridMargin,
    this.footerWidget,
    this.headerWidget,
    this.keepAlive = false,

    ///related to load more..
    this.pullRefresh = true,
    required this.builder,

    ///loader..
    this.loadingMoreWidget = const Center(child: CircularProgressIndicator()),
    this.loadingWidget,
    this.loaderSize,
    this.noDataFoundWidget,
    this.errorWidget,
    required this.controller,
  })  : assert(
          // coverage:ignore-start
          minItemWidth > 0,
          'minItemWidth has to be > 0. It instead was set to $minItemWidth',
        ),
        assert(
          minItemsPerRow > 0,
          'minItemsPerRow has to be > 0. It instead was set to $minItemsPerRow',
        ),
        assert(
          maxItemsPerRow == null || maxItemsPerRow >= minItemsPerRow,
          'maxItemsPerRow can only be null or >= minItemsPerRow '
          '($minItemsPerRow). It instead was set to $maxItemsPerRow',
        );

  Map<String, dynamic> getItemCountAndWidth(
    double maxWidth,
    int length,
  ) {
    double itemWidth;

    // Start with the minimum allowed number of items per row.
    var itemsPerRow = minItemsPerRow;

    // Calculate the current width according to the items per row
    var currentWidth =
        itemsPerRow * minItemWidth + (itemsPerRow - 1) * horizontalGridSpacing;

    // Add outer margin (vertical) if set
    if (horizontalGridMargin != null) {
      currentWidth += 2 * horizontalGridMargin!;
    }

    // While another pair of spacing + minItemWidth fits the row, add it to
    // the variables. Only add items while maxItemsPerRow is not reached.
    while (currentWidth < maxWidth &&
        (maxItemsPerRow == null || itemsPerRow < maxItemsPerRow!)) {
      if (currentWidth + (minItemWidth + horizontalGridSpacing) <= maxWidth) {
        // If another spacing + item fits in the row, add one item to the row
        // and update the currentWidth
        currentWidth += minItemWidth + horizontalGridSpacing;
        itemsPerRow++;
      } else {
        // If no other item + spacer fits into the row, break
        break;
      }
    }

    // Calculate the spacers per row (they are only in between the items, not
    // at the edges)
    final spacePerRow = itemsPerRow - 1;

    // Calculate the itemWidth that results from the maxWidth and number of
    // spacers and outer margin (horizontal)
    itemWidth = (maxWidth -
            (spacePerRow * horizontalGridSpacing) -
            (2 * (horizontalGridMargin ?? 0))) /
        itemsPerRow;
    // partition(length, itemsPerRow)
    int quotient = length ~/ itemsPerRow; // Quotient
    int remainder = length % itemsPerRow; // Remainder

    return {
      'item_count': itemsPerRow,
      'item_width': itemWidth,
      'quotient': quotient,
      'remainder': remainder,
    };
  }

  @override
  PsListViewState<T> createState() => PsListViewState<T>();
}

class PsListViewState<T> extends State<PsListView<T>>
    with AutomaticKeepAliveClientMixin<PsListView<T>> {
  List<T>? futureList;
  int page = 1;
  bool? isLastPage;
  bool loadingFuture = false;
  int requestingTime = 0;
  List<Completer> completerList = [];

  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  void initState() {
    super.initState();
    loadFutureList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    widget.controller._bind(this);
    if (widget.controller.futureList != null) {
      futureList = widget.controller.futureList;
    }
    if ((futureList == null || (futureList as List).isEmpty)) {
      if (loadingFuture || (widget.controller.isLoading ?? false)) {
        return (widget.loadingWidget ??
            widget.loadingMoreWidget ??
            const Center(child: CircularProgressIndicator()));
      } else if ((widget.controller.noDataFound ?? false) ||
          (!loadingFuture && futureList != null)) {
        ///its means it is empty
        return (widget.noDataFoundWidget != null
            ? widget.noDataFoundWidget!(widget.controller)
            : const Center(child: Text("NO DATA FOUND")));
      } else {
        return (widget.errorWidget != null
            ? widget.errorWidget!(widget.controller)
            : const Center(child: Text("SOMETHING WENT WRONG !!")));
      }
    }
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        futureList ??= [];
        Map<String, dynamic> items = widget.getItemCountAndWidth(
          constraints.maxWidth -
              (widget.listViewBuilderOptions?.padding?.horizontal ?? 0),
          futureList!.length,
        );

        if (widget.controller.onItemCount != null) {
          widget.controller.onItemCount!(items['item_count']);
        }
        if (widget.controller.onItemWidth != null) {
          widget.controller.onItemWidth!(items['item_width']);
        }
        int itemCount = (items['quotient']) + (items['remainder'] > 0 ? 1 : 0);
        int indexAdd = (widget.loadingMoreWidget != null ? 1 : 0) +
            (widget.headerWidget != null ? 1 : 0) +
            (widget.footerWidget != null ? 1 : 0) +
            ((widget.loaderSize ?? 1) - 1);
        itemCount = indexAdd + itemCount;
        Widget child = ListView.builder(
          itemCount: itemCount,
          itemBuilder: (BuildContext context, int index) {
            if (index >= itemCount - 1) {
              if (!(widget.controller.isLastPage ?? true) && !loadingFuture) {
                isLastPage = widget.controller.isLastPage;
                loadingFuture = true;
                int page = widget.controller.page ?? 1;
                page++;
                widget.controller
                    .onFuture(page, widget.controller.perPage, {}).then((s) {
                  loadingFuture = false;
                });
              } else if (!(isLastPage ?? true) && !loadingFuture) {
                loadFutureList(loadMore: true);
              }
            }
            if (widget.footerWidget != null && (index >= itemCount - 1)) {
              return widget.footerWidget;
            } else if ((index >=
                    (itemCount - 1) - (widget.footerWidget != null ? 1 : 0) &&
                ((widget.maxItemsPerRow == 1) || widget.loaderSize == null))) {
              if (isLastPage ?? true) {
                return const SizedBox();
              } else {
                if (widget.maxItemsPerRow != 1 && widget.loaderSize != null) {
                  return const SizedBox();
                } else {
                  return widget.loadingMoreWidget;
                }
              }
            } else if (widget.headerWidget != null && ((index == 0))) {
              return widget.headerWidget;
            } else {
              index = widget.headerWidget != null ? (index - 1) : index;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.verticalGridMargin != null)
                    SizedBox(height: widget.verticalGridMargin),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: widget.rowMainAxisAlignment,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.horizontalGridMargin != null)
                        SizedBox(width: widget.horizontalGridMargin),
                      ...List.generate(items['item_count'], (i) {
                        int index2 =
                            (i + (items['item_count'] * (index))).toInt();
                        return SizedBox(
                          width: items['item_width'],
                          child: (((futureList?.length ?? 0) - 1) < index2)
                              ? widget.loaderSize == null
                                  ? const SizedBox()
                                  : widget.loadingMoreWidget ??
                                      const LinearProgressIndicator()
                              : widget.builder(
                                  context,
                                  futureList!,
                                  (i + (items['item_count'] * (index))).toInt(),
                                ),
                        );
                      }),
                      if (widget.horizontalGridMargin != null)
                        SizedBox(width: widget.horizontalGridMargin),
                    ],
                  ),
                  if (widget.verticalGridMargin != null)
                    SizedBox(height: widget.verticalGridMargin),
                ],
              );
            }
          },
          scrollDirection:
              widget.listViewBuilderOptions?.scrollDirection ?? Axis.vertical,
          reverse: widget.listViewBuilderOptions?.reverse ?? false,
          controller: widget.listViewBuilderOptions?.controller,
          primary: widget.listViewBuilderOptions?.primary,
          physics: widget.listViewBuilderOptions?.physics,
          shrinkWrap: widget.listViewBuilderOptions?.shrinkWrap ?? false,
          padding: widget.listViewBuilderOptions?.padding,
          itemExtent: widget.listViewBuilderOptions?.itemExtent,
          prototypeItem: widget.listViewBuilderOptions?.prototypeItem,
          findChildIndexCallback:
              widget.listViewBuilderOptions?.findChildIndexCallback,
          addAutomaticKeepAlives:
              widget.listViewBuilderOptions?.addAutomaticKeepAlives ?? true,
          addRepaintBoundaries:
              widget.listViewBuilderOptions?.addRepaintBoundaries ?? true,
          addSemanticIndexes:
              widget.listViewBuilderOptions?.addSemanticIndexes ?? true,
          cacheExtent: widget.listViewBuilderOptions?.cacheExtent,
          semanticChildCount: widget.listViewBuilderOptions?.semanticChildCount,
          dragStartBehavior: widget.listViewBuilderOptions?.dragStartBehavior ??
              DragStartBehavior.start,
          keyboardDismissBehavior:
              widget.listViewBuilderOptions?.keyboardDismissBehavior ??
                  ScrollViewKeyboardDismissBehavior.manual,
          restorationId: widget.listViewBuilderOptions?.restorationId,
          clipBehavior:
              widget.listViewBuilderOptions?.clipBehavior ?? Clip.hardEdge,
        );
        return !widget.pullRefresh
            ? child
            : ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                    PointerDeviceKind.trackpad,
                    PointerDeviceKind.stylus,
                    PointerDeviceKind.invertedStylus,
                  },
                ),
                child: RefreshIndicator(
                  // color: Theme.of(context).primaryColor,
                  onRefresh: () async {
                    page = 1;
                    await loadFutureList();
                  },
                  child: child,
                ),
              );
      },
    );
  }

  Future<List<T>?> loadFutureList({bool loadMore = false, Map? params}) async {
    if (loadingFuture) {
      completerList[requestingTime].complete(null);
      requestingTime++;
    }
    int times = requestingTime;
    completerList.add(Completer());
    if (loadMore) {
      page++;
    } else {
      page = 1;
    }
    if (page == 1) {
      futureList = null;
    }
    loadingFuture = true;
    update();
    try {
      widget.controller
          .onFuture(page, widget.controller.perPage, params)
          .then((value) {
        if (completerList.length > times && !completerList[times].isCompleted) {
          completerList[times].complete(value);
        }
      });
      List<T>? futureList2 = await completerList[times].future;
      if (futureList2 != null) {
        if (times == requestingTime) {
          requestingTime = 0;
          completerList.clear();
        }
        if (page == 1) {
          futureList = futureList2;
        } else {
          futureList?.addAll(futureList2);
        }
        if ((futureList2).length == widget.controller.perPage) {
          isLastPage = false;
        } else {
          isLastPage = true;
        }
      }
    } catch (e) {
      debugPrint("ERROR AIS ::  $e");
    }
    if (requestingTime != 0) {
      // requestingTime--;
    } else {
      loadingFuture = false;
      update();
    }
    return futureList;
  }

  void update() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }
}
