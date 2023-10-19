/************************** is_all_greater_than ************************/

%% #1 10-points
%is_all_greater_than(List, N): succeed iff all numbers in list of
%numbers List are greater than N.
%%Hint: use recursion on List.

is_all_greater_than([], _).
is_all_greater_than([M|[]], N) :- M > N.
is_all_greater_than([M|TAIL], N) :- M > N, is_all_greater_than(TAIL, N).

/*************************** get_greater_than1 *************************/

%% #2 10-points
%get_greater_than1(List, N, M): succeed iff M matches a number in List
%which is greater than N.
%
%Example:
% ?- get_greater_than1([2, 3, 1, 4], 2, M).
% M = 3 ;
% M = 4 ;
% false.
%
%Restriction: May not use any auxiliary procedures.
%Hint: Use separate rules for head and tail of List.

get_greater_than1([X|_], N, M) :- X = M, M > N.
get_greater_than1([X|TAIL], N, M) :- X \= M; get_greater_than1(TAIL, N, M).

/*************************** get_greater_than2 *************************/

%% #3 10-points
%get_greater_than2(List, N, M): succeed iff M matches a number in List
%which is greater than N.  Same spec as previous exercise.
%Restriction: Must be a single rule which uses member/2.
%Hint: use generate-and-test with member/2 used to generate
%and comparison used to test.

get_greater_than2(List, N, M) :- member(M, List), M > N.

/************************* get_all_greater_than ************************/

%% #4 15-points
%get_all_greater_than(List, N, GreaterThanN): GreaterThanN matches
%the list of numbers from List (in order) which are greater than N.
%Restriction: May not use any auxiliary procedures.
%Hint: use a rule for empty List and two separate rules for a non-empty List.

get_all_greater_than([], _, []).
get_all_greater_than([M|TAIL], N, GreaterThanN) :- M > N, get_all_greater_than(TAIL, N, GreaterThanN1), append([M], GreaterThanN1, GreaterThanN).
get_all_greater_than([M|TAIL], N, GreaterThanN) :- M =< N, get_all_greater_than(TAIL, N, GreaterThanN).
    
/*********************** get_all_greater_than_tr ***********************/

%% #5 15-points
%get_all_greater_than_tr(List, N, GreaterThanN): GreaterThanN matches
%the list of numbers from List (in order) which are greater than N.
%The procedure must be tail-recursive; i.e. the "return value" of
%any recursive calls must be the "return value" of the original call.
%Restriction: May define and use a *single* auxiliary procedure and
%either reverse/2 or append/3.
%Hint: Define an auxiliary procedure witn an extra argument which
%accumulates GreaterThanN.

    get_all_greater_than_tr([], _, []).
    get_all_greater_than_tr([M|TAIL], N, GreaterThanN) :- M =< N, get_all_greater_than(TAIL, N, GreaterThanN).
    get_all_greater_than_tr([M|TAIL], N, GreaterThanN) :- M > N, get_aux(M, GreaterThanN, GreaterThanN1), get_all_greater_than(TAIL, N, GreaterThanN1).
    get_aux(M, GreaterThanN, GreaterThanN1) :- append([M], GreaterThanN, GreaterThanN1).
    
/*************************** split_into_pairs **************************/

%% #6 10-points
%split_into_pairs(List, PairList): PairList is a list of pairs (2-element
%lists) of elements of List in order.  If List has odd length, then the
%last element of PairList will match a 1-element list containing the last
%element of List.
%Restriction: May not use any auxiliary procedures.
%Hint: consider cases of List empty, List a 1-element list and List
%containing 2-or-more elements.

    split_into_pairs([], _).
    split_into_pairs([A|[]], PairList) :- append(PairList, [[A]], PairList1), split_into_pairs([], PairList1).
    split_into_pairs([A|[B|TAIL]], PairList) :- append(PairList, [[A, B]], PairList1), split_into_pairs(TAIL, PairList1).
    
/******************************** sum_areas ****************************/
%% #7 10-points
%sum_areas(Shapes, SumArea): match SumArea to the sum of the shapes in
%list Shapes.  A shape is either rect(X, Y, W, H) with area W*H or
%circ(X, Y, R) with area pi * R * R (note pi is defined on the
%RHS of is/2).

    sum_areas([], SumArea) :- SumArea = 0.
    sum_areas([circ(_, _, R)|TAIL], SumArea) :- sum_areas(TAIL, SumArea1), SumArea = SumArea1 + R * R * pi.
    sum_areas([rect(_, _, L, W)|TAIL], SumArea) :- sum_areas(TAIL, SumArea1), SumArea = SumArea1 + L * W.
			     
/******************************* n_prefix ******************************/

%% #8 10-points
%n_prefix(N, List, Prefix, Rest): Prefix matches the N-prefix of list List
%and Rest matches the rest of the list.  It is assumed that N > 0 and
%length(List) >= N.
%Restriction: May not use any auxiliary procedures.
%Hint: Recurse on N.

    n_prefix(1, [A|TAIL], Prefix, Rest) :- Rest = TAIL, Prefix = [A].
   %% n_prefix(N, [A|TAIL], Prefix, Rest) :- N1 = N - 1, n_prefix(N1, TAIL, Prefix1, Rest1), Rest = Rest1, append([A], Prefix1, Prefix2), Prefix = Prefix2.
    n_prefix(N, [A|TAIL], Prefix, Rest) :- N = N - 1, n_prefix(N, TAIL, Prefix1, Rest), append([[A], Prefix1], Prefix).
			      
/***************************** split_into_n_lists **********************/

%% #9 10-points
%split_into_n_lists(N, List, NLists): match NLists with the N-element
%sublists of List in order.  If length(List) is not divisible by N,
%leaving some leftover elements, then the last element of NLists will
%match the leftover elements of List.  It is assumed that N > 0.
%Hint: List is either empty or non-empty.  If non-empty, its
%length is < N, or its length is >= N; in the latter case, use n_prefix/3
%to recurse.

    split_into_n_lists(_, [], []).
    split_into_n_lists(N, List, [NHead|NTail]) :- length(List, Length), Length < N, split_aux(Length, List, [NHead, Rest]), split_into_n_lists(N, Rest, NTail).
    split_into_n_lists(N, List, [NHead|NTail]) :- length(List, Length), Length >= N, split_aux(N, List, [NHead, Rest]), split_into_n_lists(N, Rest, NTail).
    split_aux(N, List, [H|[T]]) :- append(H, T, List), length(H, N).																      	  
     
